import '../../constants/imports.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit boxFit;
  final double? width;
  final double? height;
  final Alignment alignment;

  const AppImage({
    super.key,
    required this.imageUrl,
    this.boxFit = BoxFit.cover,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  bool isValidUrl(String imageUrl) {
    if (imageUrl.isEmpty) return false;
    return imageUrl.startsWith('assets') ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: isValidUrl(imageUrl)
          ? Image.network(
              imageUrl,
              fit: boxFit,
              alignment: alignment,
            )
          : Image.asset(
              imageUrl,
              fit: boxFit,
              alignment: alignment,
            ),
    );
  }
}
