import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class FormBlocListener<T extends FormBloc<D, E>, D, E> extends StatelessWidget {
  const FormBlocListener({
    super.key,
    required this.child,
    this.bloc,
    this.onPure,
    this.onValid,
    this.onInvalid,
    this.onLoading,
    this.onSuccess,
    this.onError,
  });

  final Widget child;
  final T? bloc;
  final void Function()? onPure;
  final void Function()? onValid;
  final void Function()? onInvalid;
  final void Function()? onLoading;
  final void Function(D data)? onSuccess;
  final void Function(E error)? onError;

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, FormBlocState<D, E>>(
      bloc: bloc,
      listener: (context, state) {
        if (state is FormPureState<D, E>) {
          onPure?.call();
        }
        if (state is FormValidState<D, E>) {
          onValid?.call();
        }
        if (state is FormInvalidState<D, E>) {
          onInvalid?.call();
        }
        if (state is FormLoadingState<D, E>) {
          onLoading?.call();
        }
        if (state is FormSuccessState<D, E>) {
          onSuccess?.call(state.data);
        }
        if (state is FormErrorState<D, E>) {
          onError?.call(state.error);
        }
      },
      child: child,
    );
  }
}
