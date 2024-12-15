import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import '../../../../constants/imports.dart';

class CardBackgroundEditor extends StatefulWidget {
  final File imageFile;
  final void Function(File scaledImage, double blur) onConfirm;

  const CardBackgroundEditor({super.key, required this.imageFile, required this.onConfirm});

  @override
  State<CardBackgroundEditor> createState() => _CardBackgroundEditorState();
}

class _CardBackgroundEditorState extends State<CardBackgroundEditor> {
  late TransformationController _controller;
  final GlobalKey _cardKey = GlobalKey();
  double blur = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              key: _cardKey,
              child: InteractiveViewer(
                transformationController: _controller,
                minScale: 1,
                maxScale: 5.0,
                child: Image.file(widget.imageFile, fit: BoxFit.cover),
              ),
            ),
          ),
          Center(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(
                sigmaX: blur,
                sigmaY: blur,
              ),
              child: Container(
                width: 300,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                color: AppColors.backgroundColor,
              ),
              child: Column(
                children: [
                  Slider(
                    value: blur,
                    min: 0,
                    max: 10,
                    label: blur.toString(),
                    onChanged: (value) {
                      setState(() {
                        blur = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () async {
                            await _takeScreenshot();
                          },
                          text: 'Confirm'.tr,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Cancel'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takeScreenshot() async {
    try {
      RenderRepaintBoundary boundary = _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        final screenshotFile = File('${widget.imageFile.path}_cropped.png');
        await screenshotFile.writeAsBytes(pngBytes);

        widget.onConfirm(screenshotFile, blur);
      }
    } catch (e) {
      print("Error capturing screenshot: $e");
    }
  }
}
