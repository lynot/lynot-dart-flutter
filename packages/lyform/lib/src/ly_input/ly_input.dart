import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';

part 'ly_input_state.dart';
part 'ly_input_validator.dart';
part 'ly_validation_type.dart';

class LyInput<T> extends Cubit<LyInputState<T>> {
  LyInput({
    required T pureValue,
    LyValidationType? validationType,
    LyBaseValidator<T>? validator,
    this.debugName,
    this.onPreDirty,
    this.onPostDirty,
    this.onPrePure,
    this.onPostPure,
    this.onPreValidate,
    this.onPostValidate,
  })  : validationType = validationType ??
            (validator != null
                ? LyValidationType.always
                : LyValidationType.none),
        validator = validator ?? const LyEmptyValidator(),
        super(
          LyInputState(
            value: pureValue,
            pureValue: pureValue,
            lastNotNullValue: pureValue,
            debugName: debugName,
          ),
        );

  final LyBaseValidator<T> validator;
  final LyValidationType validationType;
  final String? debugName;

  bool get isPure => state.pureValue == state.value;
  bool get isValid => state.error == null;
  bool get isInvalid => state.error != null;

  T get value => state.value;
  T get pureValue => state.pureValue;
  T get lastNotNullValue => state.lastNotNullValue;

  bool Function(LyInput<T> self, T value)? onPreDirty;
  bool Function(LyInput<T> self, T value)? onPostDirty;
  bool Function(LyInput<T> self, T value)? onPrePure;
  bool Function(LyInput<T> self, T value)? onPostPure;
  bool Function(LyInput<T> self)? onPreValidate;
  bool Function(LyInput<T> self)? onPostValidate;

  bool dirty(T value) {
    final onPreDirtyResult = onPreDirty?.call(this, value) ?? true;
    if (!onPreDirtyResult) {
      return false;
    }
    final pureValue = state.pureValue;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final error = state.error;
    final debugName = state.debugName;
    emit(
      LyInputState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        error: error,
        debugName: debugName,
      ),
    );
    if (validationType == LyValidationType.always) {
      validate();
    }
    return onPostDirty?.call(this, value) ?? true;
  }

  bool pure(T value) {
    final onPrePureResult = onPrePure?.call(this, value) ?? true;
    if (!onPrePureResult) {
      return false;
    }
    final pureValue = value;
    final lastNotNullValue = value ?? state.lastNotNullValue;
    final debugName = state.debugName;
    emit(
      LyInputState<T>(
        value: value,
        pureValue: pureValue,
        lastNotNullValue: lastNotNullValue,
        debugName: debugName,
      ),
    );
    if (validationType == LyValidationType.always) {
      validate();
    }
    return onPostPure?.call(this, value) ?? true;
  }

  bool validate() {
    final onPreValidateResult = onPreValidate?.call(this) ?? true;
    if (!onPreValidateResult) {
      return false;
    }
    if (validationType != LyValidationType.none) {
      final value = state.value;
      final pureValue = state.pureValue;
      final lastNotNullValue = state.lastNotNullValue;
      final error = validator(state.value);
      final debugName = state.debugName;
      emit(
        LyInputState<T>(
          value: value,
          pureValue: pureValue,
          lastNotNullValue: lastNotNullValue,
          error: error,
          debugName: debugName,
        ),
      );
    }
    return onPostValidate?.call(this) ?? true;
  }
}
