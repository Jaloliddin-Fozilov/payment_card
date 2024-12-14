import 'card_background_model.dart';

enum CardType { visa, masterCard, humo, uzcard }

class CardModel {
  final int id;
  final int cardNumber;
  final String cardHolderName;
  final DateTime expiryDate;
  final CardBackgroundModel cardBackgroundModel;
  final CardType cardType;

  CardModel(
      {required this.id,
      required this.cardNumber,
      required this.cardHolderName,
      required this.expiryDate,
      required this.cardBackgroundModel,
      required this.cardType});

  CardModel copyWith(
          {int? id,
          int? cardNumber,
          String? cardHolderName,
          DateTime? expiryDate,
          CardBackgroundModel? cardBackgroundModel,
          CardType? cardType,
          bool? darkMode}) =>
      CardModel(
        id: id ?? this.id,
        cardNumber: cardNumber ?? this.cardNumber,
        cardHolderName: cardHolderName ?? this.cardHolderName,
        expiryDate: expiryDate ?? this.expiryDate,
        cardBackgroundModel: cardBackgroundModel ?? this.cardBackgroundModel,
        cardType: cardType ?? this.cardType,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['card_number'] = cardNumber;
    data['card_holder_name'] = cardHolderName;
    data['expiry_date'] = expiryDate.toIso8601String();
    data['card_background'] = cardBackgroundModel.toJson();
    data['card_type'] = cardType.name;

    return data;
  }

  List<Object> get props => [
        id,
        cardNumber,
        cardHolderName,
        expiryDate,
        cardBackgroundModel,
        cardType,
      ];
}
