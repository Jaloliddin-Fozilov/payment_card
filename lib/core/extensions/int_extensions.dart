extension CardNumberFormatter on int {
  /// CardNumber `XXXX XXXX XXXX XXXX` formatter
  String toCardNumberFormat() {
    String numberString = toString();

    if (numberString.length != 16) {
      throw const FormatException("Card number must have exactly 16 digits.");
    }

    return numberString.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} ');
  }
}
