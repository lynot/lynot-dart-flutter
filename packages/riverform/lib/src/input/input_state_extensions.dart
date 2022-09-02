import 'package:riverform/riveform.dart';

extension InputStateTypeExtensions on InputState {
  bool get isPure => type == InputStateType.pure;
  bool get isUnknow => type == InputStateType.unknow;
  bool get isChecking => type == InputStateType.checking;
  bool get isValid => type == InputStateType.valid;
  bool get isInvalid => type == InputStateType.invalid;
}
