import 'package:equatable/equatable.dart';

enum FormValidState {
  /// The valid state is unknow until validation
  unknow,

  /// Is validation async
  checking,

  /// Every input is valid
  valid,

  /// Some inputs had errors
  invalid,
}

class FormStateData extends Equatable {
  const FormStateData({
    required this.values,
    required this.validState,
    required this.isPure,
  });

  final FormValidState validState;
  final bool isPure;

  final Map<String, dynamic> values;

  @override
  List<Object?> get props => [validState, isPure];

  dynamic operator [](String inputId) => values[inputId];
}
