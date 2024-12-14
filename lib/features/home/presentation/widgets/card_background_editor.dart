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
              child: Column(
                children: [
                  AppButton(
                    text: 'Blur'.tr,
                    width: Get.width,
                    color: AppColors.secondaryColor,
                    onTap: () {
                      double newBlur = blur;
                      Get.bottomSheet(Container(
                        padding: const EdgeInsets.all(16),
                        child: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                              color: AppColors.backgroundColor,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Slider(
                                  value: newBlur,
                                  min: 0,
                                  max: 10,
                                  label: blur.toString(),
                                  onChanged: (value) {
                                    setState(() {
                                      newBlur = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }),
                      )).then((value) {
                        if (value != null) {
                          setState(() {
                            newBlur = value;
                          });
                        }
                      });
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          onTap: () async {
                            widget.onConfirm(widget.imageFile, blur);
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
}
