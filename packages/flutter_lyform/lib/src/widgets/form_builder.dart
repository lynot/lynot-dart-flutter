import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyform/lyform.dart';

class FormBlocBuilder<T extends FormBloc> extends StatelessWidget {
  final T? bloc;

  final Widget Function()? onPure;
  final Widget Function()? onValid;
  final Widget Function()? onInvalid;
  final Widget Function()? onLoading;
  final Widget Function(dynamic data)? onSuccess;
  final Widget Function(dynamic error)? onError;

  final Widget Function() orElse;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<T, FormBlocState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is FormPureState && onPure != null) return onPure!.call();

        if (state is FormValidState && onValid != null) return onValid!.call();

        if (state is FormInvalidState && onInvalid != null)
          return onInvalid!.call();

        if (state is FormLoadingState && onLoading != null)
          return onLoading!.call();

        if (state is FormSuccessState && onSuccess != null)
          return onSuccess!.call(state.data);

        if (state is FormErrorState && onError != null)
          return onError!.call(state.error);

        return orElse();
      },
    );
  }
}
