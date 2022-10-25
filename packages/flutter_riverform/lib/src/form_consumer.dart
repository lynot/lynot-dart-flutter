import 'package:flutter/material.dart';
import 'package:flutter_riverform/src/riverform_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverform/riverform.dart';

class RiverformConsumer extends StatelessWidget {
  const RiverformConsumer({
    super.key,
    required this.builder,
  });

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    FormStateData state,
  ) builder;

  @override
  Widget build(BuildContext context) {
    final formId = RiverformProvider.of(context)!.formId;
    final form = RiverformProvider.of(context)!.form;
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(form.provider(formId));
        return builder(
          context,
          ref,
          state,
        );
      },
    );
  }
}
