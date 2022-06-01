import 'package:lyform/lyform.dart';

class IterableNotEmtpy extends Validator<Iterable> {
  IterableNotEmtpy(super.message);

  @override
  String? call(Iterable value) => value.isEmpty ? message : null;
}
