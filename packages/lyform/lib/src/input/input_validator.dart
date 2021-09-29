part of 'input_bloc.dart';

abstract class BaseValidator<T> {
  const BaseValidator();

  String? call(T value);

  BaseValidator<T> operator &(BaseValidator<T> other) {
    return AndValidator(this, other);
  }

  BaseValidator<T> operator |(BaseValidator<T> other) {
    return OrValidator(this, other);
  }
}

abstract class Validator<T> extends BaseValidator<T> {
  const Validator(this.message);

  final String message;
}

class AndValidator<T> extends BaseValidator<T> {
  const AndValidator(this.left, this.right);

  final BaseValidator<T> left;
  final BaseValidator<T> right;

  @override
  String? call(T value) {
    return left(value) ?? right(value);
  }
}

class OrValidator<T> extends BaseValidator<T> {
  const OrValidator(this.left, this.right);

  final BaseValidator<T> left;
  final BaseValidator<T> right;

  @override
  String? call(T value) {
    final result = left(value);
    return result != null && right(value) != null ? result : null;
  }
}

class ListValidator<T> extends BaseValidator<T> {
  const ListValidator(this.validators);

  final List<String? Function(T)> validators;

  @override
  String? call(T value) =>
      validators.map((e) => e(value)).where((e) => e != null).firstOrNull;
}

class EmptyValidator<T> extends BaseValidator<T> {
  const EmptyValidator();

  @override
  String? call(T value) => null;
}
