import '../../../../constants/imports.dart';

class ChooseImagePage extends StatefulWidget {
  const ChooseImagePage({super.key});

  @override
  State<ChooseImagePage> createState() => _ChooseImagePageState();
}

class _ChooseImagePageState extends State<ChooseImagePage> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customize Background'.tr),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_selectedImage != null)
              Expanded(
                child: CardBackgroundEditor(
                  imageFile: _selectedImage!,
                  onConfirm: (scaledImage, blur) async {
                    await context.read<HomeProvider>().addNewImageStyle(await CardBackgroundModel.fromBackground(
                        id: 1000 + Random().nextInt(10000), image: scaledImage.path, blur: blur));
                    Get.back();
                  },
                ),
              )
            else
              Center(
                child: AppButton(
                  onTap: _pickImage,
                  text: 'Choose Image'.tr,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
