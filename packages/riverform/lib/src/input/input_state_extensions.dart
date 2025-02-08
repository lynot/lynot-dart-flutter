import 'package:riverform/riverform.dart';

extension InputStateTypeExtensions<T> on InputStateData<T> {
  bool get isUnknow => validState == InputValidState.unknow;
  bool get isChecking => validState == InputValidState.checking;
  bool get isValid => validState == InputValidState.valid;
  bool get isInvalid => validState == InputValidState.invalid;

  T when({
    T Function()? unknow,
    T Function()? checking,
    T Function()? valid,
    T Function()? invalid,
    required T Function() orElse,
  }) {
    switch (validState) {
      case InputValidState.unknow:
        if (unknow != null) {
          return unknow.call();
        }
      case InputValidState.checking:
        if (checking != null) {
          return checking.call();
        }
      case InputValidState.valid:
        if (valid != null) {
          return valid.call();
        }
      case InputValidState.invalid:
        if (invalid != null) {
          return invalid.call();
        }
    }

    return orElse.call();
  }
}
