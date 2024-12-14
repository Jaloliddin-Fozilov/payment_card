import '../../../../constants/imports.dart';

class CardBackgroundEditor extends StatefulWidget {
  final File imageFile;
  final void Function(File scaledImage) onConfirm;

  const CardBackgroundEditor({super.key, required this.imageFile, required this.onConfirm});

  @override
  State<CardBackgroundEditor> createState() => _CardBackgroundEditorState();
}

class _CardBackgroundEditorState extends State<CardBackgroundEditor> {
  late TransformationController _controller;
  final GlobalKey _cardKey = GlobalKey();

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
            child: InteractiveViewer(
              transformationController: _controller,
              boundaryMargin: const EdgeInsets.all(80),
              minScale: 0.5,
              maxScale: 2.0,
              child: Image.file(widget.imageFile, fit: BoxFit.cover),
            ),
          ),
          Center(
            child: SizedBox(
              key: _cardKey,
              width: 300,
              height: 180,
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
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      onTap: () async {
                        widget.onConfirm(widget.imageFile);
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
            ),
          ),
        ],
      ),
    );
  }
}
