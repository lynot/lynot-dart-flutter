import 'package:riverform/riverform.dart';
import 'package:riverpod/riverpod.dart';

export 'form_state.dart';
export 'form_state_extensions.dart';

class Riverform {
  Riverform({
    required this.inputs,
  }) : super() {
    provider = StateProvider.family<FormStateData, String>(
      (ref, formId) {
        _ref = ref;

        // watch for input changes
        final allInputs = getAllInputs(formId);
        final inputsValues = {
          for (final input in allInputs)
            input.id: ref.watch(input.provider(formId))
        };

        final values = inputsValues.values;

        return FormStateData(
          isPure: values.every((input) => input.isPure),
          values: inputsValues.map((id, state) => MapEntry(id, state.value)),
          validState: values.every(
            (input) => input.isValid,
          ) // If every input is Valid then Valid
              ? FormValidState.valid
              : values.any(
                  (input) => input.isInvalid,
                ) // If any input is Invalid then Invalid
                  ? FormValidState.invalid
                  : values.any(
                      (input) => input.isChecking,
                    ) // If any input is checking then checking
                      ? FormValidState.checking
                      : FormValidState.unknow,
        );
      },
      dependencies: [for (final input in inputs) input.provider],
    );
  }

  StateProviderRef? _ref;

  late List<Rinput> inputs;
  final Map<String, List<Rinput>> _extraInputs = {};

  late StateProviderFamily<FormStateData, String> provider;

  /// The returned value can only be used for post-validation process
  Future<bool> validate(
    String formId,
  ) async {
    _assertRefDifferentOfNull();

    final allInputs = getAllInputs(formId);
    final states =
        allInputs.map((input) => _ref!.read(input.provider(formId))).toList();
    final notifiers =
        allInputs.map((e) => _ref!.read(e.provider(formId).notifier)).toList();

    var isFormValid = true;

    for (var i = 0; i < states.length; i++) {
      isFormValid &= !states[i].isInvalid; // if is invalid, then set the flag
      var isValid = true;
      if (states[i].isUnknow || states[i].isChecking) {
        isValid = await notifiers[i].validate();
        isFormValid &=
            isValid; // set the flag if invalid  OR  unknow, checking by cancelling
      }
    }

    return isFormValid;
  }

  // get all inputs, including extras
  List<Rinput> getAllInputs(String formId) {
    final inputs = this.inputs.toList();

    if (_extraInputs.containsKey(formId)) {
      inputs.addAll(_extraInputs[formId]!.toList());
    }

    return inputs;
  }

  Rinput<T> input<T>(String inputId) {
    return inputs.firstWhere((element) => element.id == inputId) as Rinput<T>;
  }

  Rinput<T> extraInput<T>(String formId, String inputId) {
    return _extraInputs[formId]!.firstWhere((element) => element.id == inputId)
        as Rinput<T>;
  }

  void addExtraInput(
    List<Rinput> inputs,
    String formId,
  ) {
    _assertRefDifferentOfNull();

    if (!_extraInputs.containsKey(formId)) {
      _extraInputs[formId] = [];
    }

    _extraInputs[formId]!.addAll(inputs);

    _ref!.refresh(provider(formId));
  }

  void _assertRefDifferentOfNull() {
    assert(_ref != null, 'Need to create the form.provider first');
  }
}
