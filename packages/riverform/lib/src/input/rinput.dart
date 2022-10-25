import 'dart:developer';

import 'package:riverform/riverform.dart';
import 'package:riverpod/riverpod.dart';

export '../validators/input_validator.dart';
export 'input_notifier.dart';
export 'input_state.dart';
export 'input_state_extensions.dart';
export 'input_valid_state.dart';
export 'input_validation_mode.dart';

class Rinput<T> {
  Rinput(
    this.id, {
    InputValidator<T> Function(Ref ref, String formId)? validatorBuilder,
    List<ProviderOrFamily>? dependencies,
    List<AlwaysAliveProviderListenable> Function(String formId)?
        validationTriggers,
    InputValidationMode validationMode = InputValidationMode.implicit,
    String? name,
  }) : super() {
    initialValueProvider = StateProviderFamily(
      (ref, arg) {
        throw Exception('Rinput must set initial value');
      },
    );

    provider = StateNotifierProvider.family<InputNotifier<T>, InputStateData<T>,
        String>(
      (ref, formId) {
        ref.onDispose(() {
          log('disposing $formId :: $id');
        });

        log('rebuild $formId :: $id');

        final initialValue = ref.watch(initialValueProvider(formId));

        final notifier = InputNotifier<T>(
          initialValue: initialValue as T,
          value: initialValue,
          ref: ref,
          formId: formId,
          validationMode: validationMode,
          validatorBuilder: validatorBuilder,
        );

        if (validationTriggers != null) {
          final validationTriggerList = validationTriggers(formId);
          for (final dependency in validationTriggerList) {
            ref.listen(
              dependency,
              (previous, next) {
                notifier.invalidateValidation();
              },
            );
          }
        }

        return notifier;
      },
      name: name ?? id,
      dependencies: [
        initialValueProvider,
        if (dependencies != null) ...dependencies,
      ],
    );
  }

  final String id;

  late StateNotifierProviderFamily<InputNotifier<T>, InputStateData<T>, String>
      provider;

  late StateProviderFamily<dynamic, String> initialValueProvider;
}
