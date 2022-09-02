import 'package:riverform/src/form/form_state.dart';

extension FomExtensions on FormState {
  bool get isPure => this == FormState.pure;
  bool get isUnknow => this == FormState.unknow;
  bool get isChecking => this == FormState.checking;
  bool get isValid => this == FormState.valid;
  bool get isInvalid => this == FormState.invalid;

  T when<T>({
    T Function()? pure,
    T Function()? unknow,
    T Function()? checking,
    T Function()? valid,
    T Function()? invalid,
    required T Function() orElse,
  }) {
    switch (this) {
      case FormState.pure:
        if (pure != null) {
          return pure.call();
        }
        break;
      case FormState.unknow:
        if (unknow != null) {
          return unknow.call();
        }
        break;
      case FormState.checking:
        if (checking != null) {
          return checking.call();
        }
        break;
      case FormState.valid:
        if (valid != null) {
          return valid.call();
        }
        break;
      case FormState.invalid:
        if (invalid != null) {
          return invalid.call();
        }
        break;
    }

    return orElse.call();
  }
}
