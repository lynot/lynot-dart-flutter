import 'package:lyform/lyform.dart';

/// {@template required_validators}
/// Type validation required.
///
/// If the provided `value` is `null` then it will be invalid and
/// will return the error [message], otherwise it returns null.
///
/// {@endtemplate}
class Required<T> extends Validator<T> {
  /// {@macro required_validators}
  Required(super.message);

  @override
  String? call(T value) => value == null ? message : null;
}
