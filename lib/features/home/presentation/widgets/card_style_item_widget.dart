import '../../../../constants/imports.dart';

class CardStyleItemWidget extends StatelessWidget {
  final CardBackgroundModel cardBackgroundModel;
  const CardStyleItemWidget({super.key, required this.cardBackgroundModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<HomeProvider>().updateCard(cardBackgroundModel.id),
      child: Container(
          width: Get.height * 0.1,
          margin: const EdgeInsets.only(right: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            image: cardBackgroundModel.isBackgroundImage
                ? DecorationImage(
                    image: cardBackgroundModel.image!.startsWith('assets')
                        ? AssetImage(cardBackgroundModel.image!)
                        : cardBackgroundModel.image!.startsWith('http')
                            ? NetworkImage(cardBackgroundModel.image!)
                            : FileImage(File(cardBackgroundModel.image!)) as ImageProvider,
                    fit: BoxFit.cover,
                  )
                : null,
            gradient: !cardBackgroundModel.isBackgroundImage && cardBackgroundModel.colors!.length > 1
                ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: cardBackgroundModel.colors!,
                  )
                : null,
            color: !cardBackgroundModel.isBackgroundImage && cardBackgroundModel.colors!.length == 1
                ? cardBackgroundModel.colors!.first
                : null,
            borderRadius: BorderRadius.circular(10),
          )),
    );
  }
}
