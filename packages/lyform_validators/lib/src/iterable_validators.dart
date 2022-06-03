import 'package:lyform/lyform.dart';

/// {@template iterable_validators}
/// Validate the `value` is not empty in iterable.
///
/// If the provided list in `value` is empty then it will be invalid and
/// will return the error message, otherwise it returns null.
/// {@endtemplate}
class IterableNotEmtpy extends Validator<Iterable> {
  /// {@macro iterable_validators}
  IterableNotEmtpy(String message) : super(message);

  @override
  String? call(Iterable value) => value.isEmpty ? message : null;
}
