import 'package:riverform/riveform.dart';
import 'package:riverpod/riverpod.dart';

export 'input_notifier.dart';
export 'input_state.dart';
export 'input_state_extensions.dart';
export 'input_state_type.dart';
export 'input_validation_mode.dart';
export 'input_validator.dart';

class Input<T> {
  Input(
    this.id, {
    InputValidator<T> Function(Reader read)? validatorBuilder,
    T? initialValue,
    List<AlwaysAliveProviderBase<InputState>> dependOnInputs = const [],
    List<AlwaysAliveProviderBase> dependOnProviders = const [],
    InputValidationMode validationMode = InputValidationMode.implicit,
    String? name,
  }) : super() {
    _value = initialValue;
    provider = StateNotifierProvider<InputNotifier<T>, InputState<T>>(
      (ref) {
        for (final d in dependOnProviders) {
          ref.watch(d);
        }

        for (final d in dependOnInputs) {
          ref.watch(d.select((state) => state.value));
        }

        return InputNotifier<T>(
          ref.read,
          value: _value,
          initialValue: initialValue,
          validationMode: validationMode,
          validatorBuilder: validatorBuilder,
        )..addListener(
            (state) {
              _value = state.value;
            },
          );
      },
      name: name,
    );
  }

  String id;

  // hold the internal state before bean rebuilded by dependencies
  T? _value;

  late StateNotifierProvider<InputNotifier<T>, InputState<T>> provider;
}
