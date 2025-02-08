import 'package:riverform/src/form/form_state.dart';

extension FomExtensions on FormValidState {
  bool get isUnknow => this == FormValidState.unknow;
  bool get isChecking => this == FormValidState.checking;
  bool get isValid => this == FormValidState.valid;
  bool get isInvalid => this == FormValidState.invalid;

  T when<T>({
    T Function()? unknow,
    T Function()? checking,
    T Function()? valid,
    T Function()? invalid,
    required T Function() orElse,
  }) {
    switch (this) {
      case FormValidState.unknow:
        if (unknow != null) {
          return unknow.call();
        }
      case FormValidState.checking:
        if (checking != null) {
          return checking.call();
        }
      case FormValidState.valid:
        if (valid != null) {
          return valid.call();
        }
      case FormValidState.invalid:
        if (invalid != null) {
          return invalid.call();
        }
    }

    return orElse.call();
  }
}
