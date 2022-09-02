import 'package:riverform/riveform.dart';
import 'package:riverpod/riverpod.dart';

export 'form_state.dart';
export 'form_state_extensions.dart';

class Riverform {
  Riverform(List<Input> inputs) : super() {
    _inputs.addAll({
      for (final input in inputs) input.id: input.provider,
    });

    provider = StateProvider<FormState>(
      (ref) {
        _ref = ref;
        // watch for input changes
        final watchedInputs = _inputs.values.map(
          (input) => ref.watch(input),
        );

        return watchedInputs.every(
          (input) => input.isPure,
        ) // If every input is Pure then Pure
            ? FormState.pure
            : watchedInputs.every(
                (input) => input.isValid,
              ) // If every input is Valid then Valid
                ? FormState.valid
                : watchedInputs.any(
                    (input) => input.isInvalid,
                  ) // If any input is Invalid then Invalid
                    ? FormState.invalid
                    : watchedInputs.any(
                        (input) => input.isChecking,
                      ) // If any input is checking then checking
                        ? FormState.checking
                        : FormState.unknow; // If not, the state is Unknow
      },
    );
  }

  StateProviderRef? _ref;

  final Map<String, StateNotifierProvider<InputNotifier, InputState>> _inputs =
      {};

  late StateProvider<FormState> provider;

  StateNotifierProvider<InputNotifier, InputState>? operator [](String id) {
    return _inputs[id];
  }

  Future<void> validate() async {
    final states = _inputs.values.map((e) => _ref!.read(e)).toList();
    final notifiers =
        _inputs.values.map((e) => _ref!.read(e.notifier)).toList();

    for (var i = 0; i < states.length; i++) {
      if (states[i].isUnknow || states[i].isPure) {
        await notifiers[i].validate();
      }
    }
  }

  void add(List<Input> inputs) {
    _inputs.addAll({for (final input in inputs) input.id: input.provider});

    if (_ref != null) {
      _ref!.refresh(provider);
    }
  }
}
