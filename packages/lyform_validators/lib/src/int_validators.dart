import 'package:lyform/lyform.dart';

class LyIntGreaterThan extends LyValidator<int> {
  LyIntGreaterThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => (value <= limit) ? message : null;
}

class LyIntGreaterEqualThan extends LyValidator<int> {
  LyIntGreaterEqualThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value < limit ? message : null;
}

class LyIntLesserThan extends LyValidator<int> {
  LyIntLesserThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value >= limit ? message : null;
}

class LyIntLesserEquealThan extends LyValidator<int> {
  LyIntLesserEquealThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value > limit ? message : null;
}

class LyIntNonNegative extends LyValidator<int> {
  LyIntNonNegative(super.message);

  @override
  String? call(int value) => value >= 0 ? null : message;
}
