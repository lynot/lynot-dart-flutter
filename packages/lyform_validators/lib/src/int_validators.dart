import 'package:lyform/lyform.dart';

class IntGreaterThan extends Validator<int> {
  IntGreaterThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => (value <= limit) ? message : null;
}

class IntGreaterEqualThan extends Validator<int> {
  IntGreaterEqualThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value < limit ? message : null;
}

class IntLesserThan extends Validator<int> {
  IntLesserThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value >= limit ? message : null;
}

class IntLesserEquealThan extends Validator<int> {
  IntLesserEquealThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int value) => value > limit ? message : null;
}

class IntNonNegative extends Validator<int> {
  IntNonNegative(String message) : super(message);

  @override
  String? call(int value) => value >= 0 ? null : message;
}
