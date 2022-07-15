import 'package:lyform/lyform.dart';

class LyRequired<T> extends LyValidator<T> {
  LyRequired(super.message);

  @override
  String? call(T value) => value == null ? message : null;
}
