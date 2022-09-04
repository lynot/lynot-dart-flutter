import 'package:flutter/material.dart';
import 'package:flutter_riverform/flutter_riverform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RiverformScope extends StatelessWidget {
  const RiverformScope({
    required this.form,
    required this.formId,
    required this.initialValues,
    super.key,
    required this.child,
  });

  final Map<String, dynamic> initialValues;
  final Riverform form;
  final String formId;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      overrides: [
        for (final input in form.inputs)
          if (initialValues.containsKey(input.id))
            input.initialValueProvider.overrideWithProvider(
              (argument) => StateProvider((ref) => initialValues[input.id]),
            )
      ],
      child: RiverformProvider(
        form: form,
        formId: formId,
        child: child,
      ),
    );
  }
}
