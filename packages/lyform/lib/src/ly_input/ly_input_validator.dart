part of 'ly_input.dart';

abstract class LyBaseValidator<T> {
  const LyBaseValidator();

  String? call(T value);

  LyBaseValidator<T> operator &(LyBaseValidator<T> other) {
    return LyAndValidator(this, other);
  }

  LyBaseValidator<T> operator |(LyBaseValidator<T> other) {
    return LyOrValidator(this, other);
  }
}

abstract class LyValidator<T> extends LyBaseValidator<T> {
  const LyValidator(this.message);

  final String message;
}

class LyAndValidator<T> extends LyBaseValidator<T> {
  const LyAndValidator(this.left, this.right);

  final LyBaseValidator<T> left;
  final LyBaseValidator<T> right;

  @override
  String? call(T value) {
    return left(value) ?? right(value);
  }
}

class LyOrValidator<T> extends LyBaseValidator<T> {
  const LyOrValidator(this.left, this.right);

  final LyBaseValidator<T> left;
  final LyBaseValidator<T> right;

  @override
  String? call(T value) {
    final result = left(value);
    return result != null && right(value) != null ? result : null;
  }
}

class LyListValidator<T> extends LyBaseValidator<T> {
  const LyListValidator(this.validators);

  final List<String? Function(T)> validators;

  @override
  String? call(T value) =>
      validators.map((e) => e(value)).where((e) => e != null).firstOrNull;
}

class LyEmptyValidator<T> extends LyBaseValidator<T> {
  const LyEmptyValidator();

  @override
  String? call(T value) => null;
}
