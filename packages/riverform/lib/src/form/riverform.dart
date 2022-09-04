import 'dart:developer';

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

        ref.onDispose(() {
          log('disposing form $formId');
        });

        // watch for input changes
        final inputsValues = {
          for (final input in inputs)
            input.id: ref.watch(input.provider(formId))
        };

        // watch for added input changes
        if (_extraInputs.containsKey(formId)) {
          inputsValues.addAll({
            for (final input in _extraInputs[formId]!)
              input.id: ref.watch(input.provider(formId))
          });
        }

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
                      : FormValidState.unknow, // If not, the state is Unknow
        );
      },
      dependencies: [for (final input in inputs) input.provider],
    );
  }

  StateProviderRef? _ref;

  late List<Rinput> inputs;
  final Map<String, List<Rinput>> _extraInputs = {};

  late StateProviderFamily<FormStateData, String> provider;

  Future<void> validate(
    String formId,
  ) async {
    _assertRefDifferentOfNull();
    log('validating form: $formId');

    final states =
        inputs.map((input) => _ref!.read(input.provider(formId))).toList();
    final notifiers =
        inputs.map((e) => _ref!.read(e.provider(formId).notifier)).toList();

    for (var i = 0; i < states.length; i++) {
      if (states[i].isUnknow || states[i].isPure) {
        await notifiers[i].validate();
      }
    }
  }

  Map<String, dynamic> getValues(
    String formId,
  ) {
    _assertRefDifferentOfNull();

    final result = <String, dynamic>{};

    result.addAll({
      for (final input in inputs)
        input.id: _ref!.read(input.provider(formId)).value
    });

    if (_extraInputs.containsKey(formId)) {
      result.addAll({
        for (final input in _extraInputs[formId]!)
          input.id: _ref!.read(input.provider(formId)).value
      });
    }

    return result;
  }

  void resetInputs(
    String formId,
    Map<String, dynamic> initialValues,
  ) {
    _assertRefDifferentOfNull();
    final inputs = getAllInputs(formId);

    for (final input in inputs) {
      _ref!.read(input.initialValueProvider(formId).state).state =
          initialValues.containsKey(input.id)
              ? initialValues[input.id]
              : input.defaultValue;
    }
  }

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
