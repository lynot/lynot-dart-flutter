import 'package:flutter/material.dart';
import 'package:flutter_riverform/flutter_riverform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverformController<T> {
  RiverformController();

  bool mounted = false;
  late Future<bool> Function() _validate;
  late void Function() _reset;

  void reset() {
    _reset.call();
  }

  Future<bool> validate() {
    return _validate.call();
  }

  void attach({
    required Future<bool> Function() validate,
    required void Function() reset,
  }) {
    mounted = true;
    _validate = validate;
    _reset = reset;
  }
}

final riverformKey = StateProvider.family<int, String>(
  (ref, formId) {
    return 0;
  },
);

class RiverformScope extends ConsumerWidget {
  RiverformScope({
    super.key,
    required this.formId,
    required this.form,
    required this.initialValues,
    required this.child,
    RiverformController? controller,
  })  : assert(
          form.inputs.every((input) => initialValues.containsKey(input.id)),
          'Must provide a initial value for every input of the form',
        ),
        controller = controller ?? RiverformController();

  final Map<String, dynamic> initialValues;
  final Riverform form;
  final String formId;
  final RiverformController controller;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    controller.attach(
      validate: () => form.validate(formId),
      reset: () {
        form.reset(formId);
        ref.read(riverformKey(formId).notifier).state++;
      },
    );

    return ProviderScope(
      overrides: [
        for (final input in form.inputs)
          input.initialValueProvider.overrideWithProvider(
            (argument) => StateProvider((ref) => initialValues[input.id]),
          ),
      ],
      child: RiverformProvider(
        form: form,
        formId: formId,
        child: child,
      ),
    );
  }
}
