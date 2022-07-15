import 'package:lyform/lyform.dart';

class LyIterableNotEmtpy extends LyValidator<Iterable> {
  LyIterableNotEmtpy(super.message);

  @override
  String? call(Iterable value) => value.isEmpty ? message : null;
}
