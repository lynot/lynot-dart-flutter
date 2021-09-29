import 'package:lyform/lyform.dart';

class GeneralRequired<T> extends Validator<T> {
  GeneralRequired(String message) : super(message);

  @override
  String? call(T value) => value == null ? message : null;
}
