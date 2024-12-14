import '../../constants/imports.dart';

extension RandomIndex<T> on List<T> {
  /// random index
  int get randomIndex {
    if (isEmpty) {
      throw StateError("List is empty");
    }
    return Random().nextInt(length);
  }
}
