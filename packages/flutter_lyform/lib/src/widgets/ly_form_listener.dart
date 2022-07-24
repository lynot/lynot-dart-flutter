import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class LyFormListener<T extends LyForm<D, E>, D, E> extends StatelessWidget {
  const LyFormListener({
    super.key,
    required this.child,
    this.bloc,
    this.onPure,
    this.onValid,
    this.onInvalid,
    this.onLoading,
    this.onSuccess,
    this.onError,
    this.onAll,
  });

  final Widget child;
  final T? bloc;
  final void Function()? onPure;
  final void Function()? onValid;
  final void Function()? onInvalid;
  final void Function()? onLoading;
  final void Function(D data)? onSuccess;
  final void Function(E error)? onError;
  final void Function(LyFormState<D, E>)? onAll;

  @override
  Widget build(BuildContext context) {
    return BlocListener<T, LyFormState<D, E>>(
      bloc: bloc,
      listener: (context, state) {
        if (state is LyFormPureState<D, E>) {
          onPure?.call();
        } else if (state is LyFormValidState<D, E>) {
          onValid?.call();
        } else if (state is LyFormInvalidState<D, E>) {
          onInvalid?.call();
        } else if (state is LyFormLoadingState<D, E>) {
          onLoading?.call();
        } else if (state is LyFormSuccessState<D, E>) {
          onSuccess?.call(state.data);
        } else if (state is LyFormErrorState<D, E>) {
          onError?.call(state.error);
        }
        onAll?.call(state);
      },
      child: child,
    );
  }
}
