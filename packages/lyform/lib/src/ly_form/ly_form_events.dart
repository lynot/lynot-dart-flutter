part of 'ly_form.dart';

abstract class LyFormEvent {
  const LyFormEvent();

  @override
  String toString() {
    return 'LyFormEvent()';
  }
}

class LyFormStartedEvent extends LyFormEvent {
  const LyFormStartedEvent();

  @override
  String toString() {
    return 'LyFormStartedEvent()';
  }
}

class LyFormChangedEvent extends LyFormEvent {
  const LyFormChangedEvent(this.debugName) : super();

  final String? debugName;

  @override
  String toString() {
    final _debugName = debugName == null ? '' : 'debugName: $debugName';
    return 'LyFormChangedEvent($_debugName)';
  }
}

class LyFormResetEvent extends LyFormEvent {
  const LyFormResetEvent() : super();

  @override
  String toString() {
    return 'LyFormResetEvent()';
  }
}

class LyFormSubmitEvent extends LyFormEvent {
  const LyFormSubmitEvent() : super();

  @override
  String toString() {
    return 'LyFormSubmitEvent()';
  }
}
