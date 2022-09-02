import 'package:riverform/riveform.dart';

class CustomSyncValidator<T> extends InputValidator<T> {
  CustomSyncValidator(this.function);

  final String? Function(T? value) function;

  @override
  Future<String?> validate(T? value) async => function.call(value);
}

class CustomAsyncValidator<T> extends InputValidator<T> {
  CustomAsyncValidator(this.function);

  final Future<String?> Function(T? value) function;

  @override
  Future<String?> validate(T? value) => function.call(value);
}
