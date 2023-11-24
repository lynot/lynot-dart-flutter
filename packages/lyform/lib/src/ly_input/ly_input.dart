import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'ly_input_event.dart';
part 'ly_input_state.dart';
part 'ly_input_validator.dart';
part 'ly_validation_type.dart';

class LyInput<T> extends Bloc<LyInputEvent<T>, LyInputState<T>> {
  LyInput({
    required T pureValue,
    LyValidationType? validationType,
    this.validator,
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
        super(
          LyInputState(
            value: pureValue,
            lastNotNullValue: pureValue,
            pureValue: pureValue,
            debugName: debugName,
          ),
        ) {
    on<LyInputDirtyEvent<T>>(
      (event, emit) async {
        await Future.delayed(Duration.zero);
        final onPreDirtyResult = onPreDirty?.call(this, event.value) ?? true;
        if (!onPreDirtyResult) {
          return;
        }
        final lastNotNullValue = event.value ?? state.lastNotNullValue;
        final pureValue = state.pureValue;
        final error = state.error;
        final debugName = state.debugName;
        emit(
          LyInputState<T>(
            value: event.value,
            lastNotNullValue: lastNotNullValue,
            pureValue: pureValue,
            error: error,
            debugName: debugName,
          ),
        );
        if (validationType == LyValidationType.always) {
          validate();
        }
        onPostDirty?.call(this, event.value);
      },
      transformer: sequential(),
    );

    on<LyInputPureEvent<T>>(
      (event, emit) async {
        await Future.delayed(Duration.zero);
        final onPrePureResult = onPrePure?.call(this, event.value) ?? true;
        if (!onPrePureResult) {
          return;
        }
        final lastNotNullValue = event.value ?? state.lastNotNullValue;
        final pureValue = event.value;
        final debugName = state.debugName;
        emit(
          LyInputState<T>(
            value: event.value,
            lastNotNullValue: lastNotNullValue,
            pureValue: pureValue,
            debugName: debugName,
          ),
        );
        if (validationType == LyValidationType.always) {
          validate();
        }
        onPostPure?.call(this, event.value);
      },
      transformer: sequential(),
    );

    on<LyInputValidateEvent<T>>(
      (event, emit) async {
        await Future.delayed(Duration.zero);
        final onPreValidateResult = onPreValidate?.call(this) ?? true;
        if (!onPreValidateResult) {
          return;
        }
        if (validationType != LyValidationType.none) {
          final value = state.value;
          final lastNotNullValue = state.lastNotNullValue;
          final pureValue = state.pureValue;
          final debugName = state.debugName;
          String? error;
          if (value != pureValue && validator != null) {
            error = validator!(state.value);
          }
          emit(
            LyInputState<T>(
              value: value,
              lastNotNullValue: lastNotNullValue,
              pureValue: pureValue,
              error: error,
              debugName: debugName,
            ),
          );
        }
        onPostValidate?.call(this);
      },
      transformer: sequential(),
    );
  }

  final LyBaseValidator<T>? validator;
  final LyValidationType validationType;
  final String? debugName;

  bool get isValid => validator?.call(value) == null;
  bool get isInvalid => !isValid;
  bool get isPure => pureValue == value;

  String? get error => state.error;
  T get value => state.value;
  T get lastNotNullValue => state.lastNotNullValue;
  T get pureValue => state.pureValue;

  bool Function(LyInput<T> self, T value)? onPreDirty;
  bool Function(LyInput<T> self, T value)? onPostDirty;
  bool Function(LyInput<T> self, T value)? onPrePure;
  bool Function(LyInput<T> self, T value)? onPostPure;
  bool Function(LyInput<T> self)? onPreValidate;
  bool Function(LyInput<T> self)? onPostValidate;

  void dirty(T value) {
    add(LyInputDirtyEvent<T>(value));
  }

  void pure(T value) {
    add(LyInputPureEvent<T>(value));
  }

  void validate() {
    add(LyInputValidateEvent<T>());
  }

  @override
  String toString() =>
      'LyInput(value: $value, error: $error, validationType: $validationType, debugName: $debugName)';
}
