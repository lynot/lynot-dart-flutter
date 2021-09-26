import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class FormBlocBuilder<T extends FormBloc> extends StatelessWidget {
  const FormBlocBuilder({
    Key? key,
    this.bloc,
    this.onPure,
    this.onValid,
    this.onInvalid,
    this.onLoading,
    this.onSuccess,
    this.onError,
    required this.orElse,
  }) : super(key: key);

  final T? bloc;
  final Widget Function()? onPure;
  final Widget Function()? onValid;
  final Widget Function()? onInvalid;
  final Widget Function()? onLoading;
  final Widget Function(dynamic data)? onSuccess;
  final Widget Function(dynamic error)? onError;
  final Widget Function() orElse;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, FormBlocState>(
      bloc: bloc,
      builder: (context, state) {
        return _build(context, state) ?? orElse();
      },
    );
  }

  Widget? _build(BuildContext context, FormBlocState state) {
    if (state is FormPureState) {
      return onPure?.call();
    }
    if (state is FormValidState) {
      return onValid?.call();
    }
    if (state is FormInvalidState) {
      return onInvalid?.call();
    }
    if (state is FormLoadingState) {
      return onLoading?.call();
    }
    if (state is FormSuccessState) {
      return onSuccess?.call(state.data);
    }
    if (state is FormErrorState) {
      return onError?.call(state.error);
    }
  }
}
