import '../../constants/imports.dart';

Future<void> pickerColors(BuildContext context) async {
  Color pickedColor = AppColors.primaryColor;
  List<Color> pickedColors = [];
  Get.defaultDialog(
      title: 'Select color'.tr,
      content: StatefulBuilder(builder: (context, setState) {
        return Column(
          children: [
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: pickedColors
                  .map(
                    (color) => Chip(
                      label: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onDeleted: () => setState(() => pickedColors.remove(color)),
                    ),
                  )
                  .toList(),
            ),
            ColorPicker(
              pickerColor: pickedColor,
              onColorChanged: (newColor) {
                pickedColor = newColor;
              },
            ),
            AppButton(
              text: 'Add'.tr,
              width: Get.width,
              color: AppColors.secondaryColor,
              onTap: () => setState(() => pickedColors.add(pickedColor)),
            )
          ],
        );
      }),
      confirm: AppButton(
        text: 'Save'.tr,
        color: AppColors.primaryColor,
        onTap: () async {
          if (pickedColors.isNotEmpty) {
            await context.read<HomeProvider>().addNewColorStyle(await CardBackgroundModel.fromBackground(
                  id: 100 + Random().nextInt(100000),
                  colors: pickedColors,
                ));
          } else {
            Get.snackbar('You must select at least one color'.tr, '', backgroundColor: Colors.red);
          }
        },
      ),
      cancel: AppButton(
        text: 'Cancel'.tr,
        color: Colors.grey,
        onTap: () => Get.back(),
      ));
}
