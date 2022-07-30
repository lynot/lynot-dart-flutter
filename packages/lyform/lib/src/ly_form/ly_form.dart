import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:lyform/lyform.dart';

part 'ly_form_events.dart';
part 'ly_form_states.dart';

abstract class LyForm<D, E> extends Bloc<LyFormEvent, LyFormState<D, E>>
    implements Iterable<LyInput<dynamic>> {
  LyForm() : super(const LyFormPureState()) {
    on<LyFormAddInputsEvent>((event, emit) async {
      await onAddInputsEvent(event, emit);
    });

    on<LyFormChangedEvent>((event, emit) async {
      await onChangedEvent(emit);
    });

    on<LyFormResetEvent>((event, emit) async {
      await onResetEvent(emit);
    });

    on<LyFormSubmitEvent>((event, emit) async {
      await onSubmitEvent(emit);
    });

    on<LyFormAddInputEvent>((event, emit) async {
      await onAddInputEvent(event, emit);
    });

    on<LyFormRemoveInputEvent>((event, emit) async {
      await onRemoveInputEvent(event, emit);
    });
  }

  @override
  void onTransition(Transition<LyFormEvent, LyFormState<D, E>> transition) {
    super.onTransition(transition);
    final state = transition.nextState;
    if (state is LyFormPureState<D, E>) {
      onPureState(state);
    } else if (state is LyFormInvalidState<D, E>) {
      onInvalidState(state);
    } else if (state is LyFormValidState<D, E>) {
      onValidState(state);
    } else if (state is LyFormLoadingState<D, E>) {
      onLoadingState(state);
    } else if (state is LyFormSuccessState<D, E>) {
      onSuccessState(state);
    } else if (state is LyFormErrorState<D, E>) {
      onErrorState(state);
    }
  }

  Stream<LyFormState<D, E>> onSubmit();
  final _inputs = <LyInput<dynamic>>[];
  final _subscriptions = <StreamSubscription<LyInputState<dynamic>>>[];

  LyInput<dynamic> operator [](int index) => _inputs[index];
  @override
  int get length => _inputs.length;

  /// Called when the form is started.
  Future<void> onAddInputsEvent(
    LyFormAddInputsEvent event,
    Emitter<LyFormState<D, E>> emit,
  ) async {
    _inputs.addAll(event.inputs);
    for (final input in _inputs) {
      _subscriptions.add(
        input.stream.listen((input) => change(input.debugName)),
      );
    }
    await onChangedEvent(emit);
  }

  /// Called when the form is changed.
  Future<void> onChangedEvent(Emitter<LyFormState<D, E>> emit) async {
    if (isPure()) {
      emit(LyFormPureState<D, E>());
    } else if (isValid()) {
      emit(LyFormValidState<D, E>());
    } else {
      emit(LyFormInvalidState<D, E>());
    }
  }

  /// Called when the form is reset.
  Future<void> onResetEvent(Emitter<LyFormState<D, E>> emit) async {
    for (final input in _inputs) {
      input.pure(input.pureValue);
    }
  }

  /// Called when the form is submitted.
  Future<void> onSubmitEvent(Emitter<LyFormState<D, E>> emit) async {
    validate();
    if (!isValid()) {
      emit(LyFormInvalidState<D, E>());
    } else {
      emit(LyFormLoadingState<D, E>());
      await for (final state in onSubmit()) {
        emit(state);
      }
    }
  }

  /// Called when the form is added an input.
  Future<void> onAddInputEvent(
    LyFormAddInputEvent event,
    Emitter<LyFormState<D, E>> emit,
  ) async {
    if (event.index < 0 || event.index > _inputs.length) {
      throw Exception('Index out of range.');
    }
    _inputs.insert(event.index, event.input);
    _subscriptions.insert(
      event.index,
      event.input.stream.listen((input) => change(input.debugName)),
    );
    await onChangedEvent(emit);
  }

  /// Called when the form is removed an input.
  Future<void> onRemoveInputEvent(
    LyFormRemoveInputEvent event,
    Emitter<LyFormState<D, E>> emit,
  ) async {
    if (event.index < 0 || event.index > _inputs.length) {
      throw Exception('Index out of range.');
    }
    _inputs.removeAt(event.index);
    await _subscriptions.removeAt(event.index).cancel();
    await onChangedEvent(emit);
  }

  /// Called when the form transitions to the [LyFormPureState].
  void onPureState(LyFormPureState<D, E> state) {}

  /// Called when the form transitions to the [LyFormValidState].
  void onValidState(LyFormValidState<D, E> state) {}

  /// Called when the form transitions to the [LyFormInvalidState].
  void onInvalidState(LyFormInvalidState<D, E> state) {}

  /// Called when the form transitions to the [LyFormLoadingState].
  void onLoadingState(LyFormLoadingState<D, E> state) {}

  /// Called when the form transitions to the [LyFormSuccessState].
  void onSuccessState(LyFormSuccessState<D, E> state) {
    _setPureInputs();
  }

  /// Called when the form transitions to the [LyFormErrorState].
  void onErrorState(LyFormErrorState<D, E> state) {}

  /// Are every input Valid?
  bool isValid() {
    return _inputs.every((input) => input.isValid);
  }

  /// Are every input Pure?
  bool isPure() {
    return _inputs.every((input) => input.isPure);
  }

  /// Validate all inputs and return [true] if they all are valids.
  void validate() {
    for (final input in _inputs) {
      input.validate();
    }
  }

  /// Use this if you whant to set all input as pure using they current value.
  /// Useful when a success submit happens.
  void _setPureInputs() {
    for (final input in _inputs) {
      input.pure(input.value);
    }
  }

  void change(String? debugName) {
    add(LyFormChangedEvent(debugName));
  }

  /// Submit form
  void submit() {
    add(const LyFormSubmitEvent());
  }

  /// Reset form
  void reset() {
    add(const LyFormResetEvent());
  }

  /// Add an input to the form.
  /// [index] is the index where the input will be added.
  /// [input] is the input to add.
  void addInput(int index, LyInput<dynamic> input) {
    add(LyFormAddInputEvent(index, input));
  }

  /// Remove an input from the form.
  /// [index] is the index where the input will be removed.
  void removeInput(int index) {
    add(LyFormRemoveInputEvent(index));
  }

  /// Add inputs to the form.
  /// [inputs] is the inputs to add.
  void addInputs(List<LyInput<dynamic>> inputs) {
    add(LyFormAddInputsEvent(inputs));
  }

  @override
  Future<void> close() async {
    await Future.wait<void>(_subscriptions.map((s) => s.cancel()));
    return super.close();
  }

  @override
  bool any(bool Function(LyInput<dynamic> element) test) => _inputs.any(test);

  @override
  Iterable<R> cast<R>() => _inputs.cast<R>();

  @override
  bool contains(Object? element) => _inputs.contains(element);

  @override
  LyInput<dynamic> elementAt(int index) => _inputs.elementAt(index);

  @override
  bool every(bool Function(LyInput<dynamic> element) test) =>
      _inputs.every(test);

  @override
  Iterable<T> expand<T>(
    Iterable<T> Function(LyInput<dynamic> element) toElements,
  ) =>
      _inputs.expand(toElements);

  @override
  LyInput<dynamic> get first => _inputs.first;

  @override
  LyInput<dynamic> firstWhere(
    bool Function(LyInput<dynamic> element) test, {
    LyInput<dynamic> Function()? orElse,
  }) =>
      _inputs.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(
    T initialValue,
    T Function(T previousValue, LyInput<dynamic> element) combine,
  ) =>
      _inputs.fold(initialValue, combine);

  @override
  Iterable<LyInput<dynamic>> followedBy(Iterable<LyInput<dynamic>> other) =>
      _inputs.followedBy(other);

  @override
  void forEach(void Function(LyInput<dynamic> element) action) =>
      _inputs.forEach(action);

  @override
  bool get isEmpty => _inputs.isEmpty;

  @override
  bool get isNotEmpty => _inputs.isNotEmpty;

  @override
  Iterator<LyInput<dynamic>> get iterator => _inputs.iterator;

  @override
  String join([String separator = '']) => _inputs.join(separator);

  @override
  LyInput<dynamic> get last => _inputs.last;

  @override
  LyInput<dynamic> lastWhere(
    bool Function(LyInput<dynamic> element) test, {
    LyInput<dynamic> Function()? orElse,
  }) =>
      _inputs.lastWhere(test, orElse: orElse);

  @override
  Iterable<T> map<T>(T Function(LyInput<dynamic> e) toElement) =>
      _inputs.map(toElement);

  @override
  LyInput<dynamic> reduce(
    LyInput<dynamic> Function(
      LyInput<dynamic> value,
      LyInput<dynamic> element,
    )
        combine,
  ) =>
      _inputs.reduce(combine);

  @override
  LyInput<dynamic> get single => _inputs.single;

  @override
  LyInput<dynamic> singleWhere(
    bool Function(LyInput<dynamic> element) test, {
    LyInput<dynamic> Function()? orElse,
  }) =>
      _inputs.singleWhere(test, orElse: orElse);

  @override
  Iterable<LyInput<dynamic>> skip(int count) => _inputs.skip(count);

  @override
  Iterable<LyInput<dynamic>> skipWhile(
    bool Function(LyInput<dynamic> value) test,
  ) =>
      _inputs.skipWhile(test);

  @override
  Iterable<LyInput<dynamic>> take(int count) => _inputs.take(count);

  @override
  Iterable<LyInput<dynamic>> takeWhile(
    bool Function(LyInput<dynamic> value) test,
  ) =>
      _inputs.takeWhile(test);

  @override
  List<LyInput<dynamic>> toList({bool growable = true}) =>
      _inputs.toList(growable: growable);

  @override
  Set<LyInput<dynamic>> toSet() => _inputs.toSet();

  @override
  Iterable<LyInput<dynamic>> where(
    bool Function(LyInput<dynamic> element) test,
  ) =>
      _inputs.where(test);

  @override
  Iterable<T> whereType<T>() => _inputs.whereType<T>();
}
