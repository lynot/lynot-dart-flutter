import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class InputBlocBuilder<T> extends StatelessWidget {
  const InputBlocBuilder({
    required this.builder,
    required this.bloc,
    Key? key,
  }) : super(key: key);

  final Widget Function(BuildContext, InputBlocState<T>) builder;
  final InputBloc<T> bloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputBloc<T>, InputBlocState<T>>(
      bloc: bloc,
      builder: builder,
    );
  }
}
