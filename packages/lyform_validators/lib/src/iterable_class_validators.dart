import 'package:lyform/lyform.dart';

class IterableNotEmtpy extends Validator<Iterable?> {
  IterableNotEmtpy(String message) : super(message);

  @override
  String? call(Iterable? value) =>
      value == null || value.isEmpty ? message : null;
}
