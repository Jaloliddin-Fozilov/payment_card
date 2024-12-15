import '../../../../constants/imports.dart';
import 'dart:ui' as ui;

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, provider, child) {
      final card = provider.currentCard;
      return Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          image: card.cardBackgroundModel.isBackgroundImage
              ? DecorationImage(
                  image: card.cardBackgroundModel.image!.startsWith('assets')
                      ? AssetImage(card.cardBackgroundModel.image!)
                      : card.cardBackgroundModel.image!.startsWith('http')
                          ? NetworkImage(card.cardBackgroundModel.image!)
                          : FileImage(File(card.cardBackgroundModel.image!)) as ImageProvider,
                  fit: BoxFit.cover,
                )
              : null,
          gradient: !card.cardBackgroundModel.isBackgroundImage && card.cardBackgroundModel.colors!.length > 1
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: card.cardBackgroundModel.colors!,
                )
              : null,
          color: !card.cardBackgroundModel.isBackgroundImage && card.cardBackgroundModel.colors!.length == 1
              ? card.cardBackgroundModel.colors!.first
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: card.cardBackgroundModel.blur, sigmaY: card.cardBackgroundModel.blur),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Card number'.tr,
                  style: Get.theme.textTheme.headlineSmall?.copyWith(color: card.cardBackgroundModel.textColor)),
              const SizedBox(height: 10),
              Text(card.cardNumber.toCardNumberFormat(),
                  style: Get.theme.textTheme.headlineMedium?.copyWith(color: card.cardBackgroundModel.textColor)),
              const SizedBox(height: 20),
              Text(card.cardHolderName,
                  style: Get.theme.textTheme.headlineMedium?.copyWith(color: card.cardBackgroundModel.textColor)),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${card.expiryDate.month}/${card.expiryDate.year}',
                      style: Get.theme.textTheme.headlineMedium?.copyWith(color: card.cardBackgroundModel.textColor)),
                  Text(card.cardType.name.toUpperCase(),
                      style: Get.theme.textTheme.headlineMedium?.copyWith(color: card.cardBackgroundModel.textColor)),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
