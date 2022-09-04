import 'package:equatable/equatable.dart';
import 'package:riverform/riverform.dart';

class InputStateData<T> extends Equatable {
  const InputStateData({
    required this.initialValue,
    required this.validState,
    required this.value,
    required this.error,
  });

  bool get isPure => initialValue == value;
  final InputValidState validState;
  final String? error;
  final T? value;
  final T? initialValue;

  @override
  String toString() {
    return 'state: ${validState.name}, value: $value, pure: $isPure, error: $error';
  }

  @override
  List<Object?> get props => [validState, value, error, isPure];
}
