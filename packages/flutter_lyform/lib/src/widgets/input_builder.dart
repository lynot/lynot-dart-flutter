import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class InputBlocBuilder<T, E> extends StatelessWidget {
  final Widget Function(BuildContext, InputBlocState<T, E>) builder;

  final InputBloc<T, E> bloc;

  const InputBlocBuilder({
    required this.builder,
    required this.bloc,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputBloc<T, E>, InputBlocState<T, E>>(
        bloc: bloc, builder: builder);
  }
}
