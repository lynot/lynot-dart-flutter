part of 'ly_input.dart';

class LyInputState<T> extends Equatable {
  const LyInputState({
    required this.value,
    required this.lastNotNullValue,
    required this.pureValue,
    this.error,
    this.debugName,
  });

  final T value;
  final T lastNotNullValue;
  final T pureValue;
  final String? error;
  final String? debugName;

  @override
  List<Object?> get props =>
      [value, lastNotNullValue, pureValue, error, debugName];

  LyInputState<T> clone() => LyInputState<T>(
        value: value,
        lastNotNullValue: lastNotNullValue,
        pureValue: pureValue,
        error: error,
        debugName: debugName,
      );
}
