enum FormState {
  /// Every input has no change
  pure,

  /// The valid state is unknow until validation
  unknow,

  /// Is validation async
  checking,

  /// Every input is valid
  valid,

  /// Some inputs had errors
  invalid,
}
