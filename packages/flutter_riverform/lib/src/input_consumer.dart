import 'package:flutter/material.dart';
import 'package:flutter_riverform/flutter_riverform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RinputController<T> {
  RinputController({
    required this.key,
    required this.update,
    required this.validate,
  });

  final Key key;
  final Future<void> Function() validate;
  final void Function(T value) update;
}

class RinputConsumer<T> extends StatelessWidget {
  const RinputConsumer({
    super.key,
    required this.inputId,
    required this.builder,
    this.child,
  }) : super();

  final String inputId;

  final Widget Function(
    BuildContext context,
    WidgetRef ref,
    InputStateData<T> state,
    RinputController inputController,
  ) builder;

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final formId = RiverformProvider.of(context)!.formId;
    final input = RiverformProvider.of(context)!.form.input<T>(inputId);

    return Consumer(
      child: child,
      builder: (context, ref, child) {
        final state = ref.watch(input.provider(formId));
        final notifier = ref.watch(input.provider(formId).notifier);

        return builder(
          context,
          ref,
          state,
          RinputController<T>(
            key: ValueKey(ref.watch(riverformKey(formId))),
            update: notifier.update,
            validate: notifier.validate,
          ),
        );
      },
    );
  }
}
