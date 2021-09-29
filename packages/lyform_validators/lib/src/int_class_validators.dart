import 'package:lyform/lyform.dart';

class IntRequired extends Validator<int?> {
  IntRequired(String message) : super(message);

  @override
  String? call(int? value) => value == null ? message : null;
}

class IntGreaterThan extends Validator<int?> {
  IntGreaterThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int? value) =>
      value == null || (value <= limit) ? message : null;
}

class IntGreaterEqualThan extends Validator<int?> {
  IntGreaterEqualThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int? value) => value == null || (value < limit) ? message : null;
}

class IntLesserThan extends Validator<int?> {
  IntLesserThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int? value) =>
      value == null || (value >= limit) ? message : null;
}

class IntLesserEquealThan extends Validator<int?> {
  IntLesserEquealThan(this.limit, String message) : super(message);

  final int limit;

  @override
  String? call(int? value) => value == null || (value > limit) ? message : null;
}

class IntNonNegative extends Validator<int?> {
  IntNonNegative(String message) : super(message);

  @override
  String? call(int? value) => value == null || value >= 0 ? null : message;
}
