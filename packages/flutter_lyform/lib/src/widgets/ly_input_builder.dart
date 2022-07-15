import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class LyInputBuilder<T> extends StatelessWidget {
  const LyInputBuilder({
    required this.builder,
    required this.lyInput,
    super.key,
  });

  final Widget Function(BuildContext, LyInputState<T>) builder;
  final LyInput<T> lyInput;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LyInput<T>, LyInputState<T>>(
      bloc: lyInput,
      builder: builder,
    );
  }
}
