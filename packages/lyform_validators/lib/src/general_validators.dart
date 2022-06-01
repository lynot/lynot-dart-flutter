import 'package:lyform/lyform.dart';

class Required<T> extends Validator<T> {
  Required(super.message);

  @override
  String? call(T value) => value == null ? message : null;
}
