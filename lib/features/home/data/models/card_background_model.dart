import '../../../../constants/imports.dart';

import 'dart:ui' as ui;

class CardBackgroundModel {
  final int id;
  double blur;
  bool isBackgroundImage;
  String? image;
  List<Color>? colors;
  Color? textColor;

  CardBackgroundModel({
    required this.id,
    this.blur = 2,
    this.image,
    this.colors,
    this.textColor,
  }) : isBackgroundImage = image != null;

  static Future<CardBackgroundModel> fromBackground({
    required int id,
    String? image,
    double blur = 2,
    List<Color>? colors,
  }) async {
    CardBackgroundModel model = CardBackgroundModel(id: id, image: image, colors: colors);

    if (image != null) {
      model.textColor = await _getTextColorBasedOnBackgroundImage(image.startsWith('assets')
          ? AssetImage(image)
          : image.startsWith('http')
              ? NetworkImage(image)
              : FileImage(File(image)) as ImageProvider);
    } else if (colors != null && colors.isNotEmpty) {
      model.textColor = _getTextColorBasedOnBackgroundColor(colors.first);
    }

    return model;
  }

  // Update background and recalculate text color
  Future<void> updateBackground(String? image, List<Color>? colors) async {
    if (image != null) {
      isBackgroundImage = true;
      this.image = image;
      textColor = await _getTextColorBasedOnBackgroundImage(
          image.startsWith('assets') ? AssetImage(image) : NetworkImage(image));
    } else {
      isBackgroundImage = false;
      this.colors = colors;
      textColor = _getTextColorBasedOnBackgroundColor(colors!.first);
    }
  }

  // Function to calculate text color based on background image
  static Future<Color> _getTextColorBasedOnBackgroundImage(ImageProvider imageProvider) async {
    final Completer<ui.Image> completer = Completer();
    final ImageStream stream = imageProvider.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(info.image);
      }),
    );

    final ui.Image image = await completer.future;
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
    final Uint8List pixels = byteData!.buffer.asUint8List();

    int totalBrightness = 0;
    for (int i = 0; i < pixels.length; i += 4) {
      final int red = pixels[i];
      final int green = pixels[i + 1];
      final int blue = pixels[i + 2];

      final double brightness = 0.299 * red + 0.587 * green + 0.114 * blue;
      totalBrightness += brightness.toInt();
    }

    final int avgBrightness = (totalBrightness ~/ (pixels.length / 4)).toInt();
    return avgBrightness < 128 ? Colors.white : Colors.black;
  }

  // Function to calculate text color based on background color
  static Color _getTextColorBasedOnBackgroundColor(Color backgroundColor) {
    double brightness = (0.299 * backgroundColor.red + 0.587 * backgroundColor.green + 0.114 * backgroundColor.blue);

    // If brightness is low (dark background), use white text, otherwise black text
    return brightness < 128 ? Colors.white : Colors.black;
  }

  CardBackgroundModel copyWith({
    int? id,
    double? blur,
    bool? isBackgroundImage,
    String? image,
    List<Color>? colors,
    Color? textColor,
  }) =>
      CardBackgroundModel(
        id: id ?? this.id,
        blur: blur ?? this.blur,
        image: image ?? this.image,
        colors: colors ?? this.colors,
        textColor: textColor ?? this.textColor,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['is_background_image'] = isBackgroundImage;
    data['image'] = image;
    data['colors'] = colors?.map((color) => color.value).toList();
    return data;
  }
}
