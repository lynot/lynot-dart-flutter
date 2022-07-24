import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class LyFormBuilder<T extends LyForm> extends StatelessWidget {
  const LyFormBuilder({
    super.key,
    this.bloc,
    this.onPure,
    this.onValid,
    this.onInvalid,
    this.onLoading,
    this.onSuccess,
    this.onError,
    required this.orElse,
  });

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
    return BlocBuilder<T, LyFormState>(
      bloc: bloc,
      builder: (context, state) {
        return _build(context, state) ?? orElse();
      },
    );
  }

  Widget? _build(BuildContext context, LyFormState state) {
    if (state is LyFormPureState) {
      return onPure?.call();
    } else if (state is LyFormValidState) {
      return onValid?.call();
    } else if (state is LyFormInvalidState) {
      return onInvalid?.call();
    } else if (state is LyFormLoadingState) {
      return onLoading?.call();
    } else if (state is LyFormSuccessState) {
      return onSuccess?.call(state.data);
    } else if (state is LyFormErrorState) {
      return onError?.call(state.error);
    }
    return null;
  }
}
