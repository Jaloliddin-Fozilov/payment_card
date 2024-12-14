import 'package:payment_card/features/home/data/models/card_model.dart';

import '../../../../constants/imports.dart';

class HomeProvider extends ChangeNotifier {
  // list local images for testing
  List<String> localBackgroundImages = [LocalImages.card1, LocalImages.card2, LocalImages.card3, LocalImages.card4];
  // Card for testing
  late CardModel currentCard;

  List<CardBackgroundModel> cardBacgroundStyles = [
    CardBackgroundModel(
      id: 0,
      colors: [Colors.red, Colors.green],
    ),
    CardBackgroundModel(
      id: 1,
      colors: [Colors.purple, Colors.yellow],
    ),
    CardBackgroundModel(
      id: 2,
      colors: [Colors.blue, Colors.green],
    ),
    CardBackgroundModel(
      id: 3,
      colors: [Colors.green, Colors.yellow],
    ),
    CardBackgroundModel(
      id: 4,
      colors: [Colors.black, Colors.green],
    ),
  ];

  Future<void> init() async {
    for (int i = 0; i < localBackgroundImages.length; i++) {
      final image = localBackgroundImages[i];
      cardBacgroundStyles.add(await CardBackgroundModel.fromBackground(id: 10 + i, image: image));
    }
    final stylesWithBackgroundImages = cardBacgroundStyles.where((e) => e.isBackgroundImage).toList();
    currentCard = CardModel(
      id: 1,
      cardNumber: 1234567890123456,
      cardHolderName: 'John Doe',
      expiryDate: DateTime.now(),
      cardType: CardType.visa,
      cardBackgroundModel: stylesWithBackgroundImages[stylesWithBackgroundImages.randomIndex],
    );
  }

  Future<void> saveCard() async {
    try {
      showLoadingAlert();
      await ApiService().makePostRequest('/payment_card/save');
      dismissLoadingAlert();
      Get.back();
      Get.snackbar('Success'.tr, 'Successfully saved card'.tr, backgroundColor: AppColors.secondaryColor);
    } catch (e) {
      dismissLoadingAlert();
      Get.snackbar('Error'.tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> deleteCard() async {
    try {
      showLoadingAlert();
      await ApiService().makePostRequest('/payment_card/delete');
      dismissLoadingAlert();
      Get.back();
      Get.snackbar('Success'.tr, 'Successfully deleted card'.tr, backgroundColor: AppColors.secondaryColor);
    } catch (e) {
      dismissLoadingAlert();
      Get.snackbar('Error'.tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> updateCard(int id) async {
    try {
      showLoadingAlert();
      await ApiService().makePostRequest('/payment_card/update', data: {'id': id});
      dismissLoadingAlert();
      currentCard = currentCard.copyWith(cardBackgroundModel: cardBacgroundStyles.firstWhere((e) => e.id == id));
      Get.closeAllSnackbars();
      Get.snackbar('Success'.tr, 'Successfully updated card'.tr,
          backgroundColor: AppColors.secondaryColor, duration: const Duration(seconds: 1));
      notifyListeners();
    } catch (e) {
      dismissLoadingAlert();
      Get.snackbar('Error'.tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> addNewColorStyle(CardBackgroundModel cardBackgroundModel) async {
    try {
      showLoadingAlert();
      cardBacgroundStyles.add(cardBackgroundModel);
      await updateCard(cardBackgroundModel.id);
      await ApiService().makePostRequest('/payment_card/add', data: currentCard.cardBackgroundModel.toJson());
      dismissLoadingAlert();
      Get.back();
    } catch (e) {
      dismissLoadingAlert();
      Get.snackbar('Error'.tr, e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> addNewImageStyle(CardBackgroundModel cardBackgroundModel) async {
    try {
      showLoadingAlert();
      cardBacgroundStyles.add(cardBackgroundModel);
      await updateCard(cardBackgroundModel.id);
      await ApiService().uploadImage('/payment_card/add', File(currentCard.cardBackgroundModel.image!));
      dismissLoadingAlert();
      Get.back();
    } catch (e) {
      dismissLoadingAlert();
      Get.snackbar('Error'.tr, e.toString(), backgroundColor: Colors.red);
    }
  }
}
