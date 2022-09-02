enum InputStateType {
  /// The input has no change
  pure,

  // before validate
  unknow,

  /// Is validating
  checking,

  /// No error
  valid,

  /// Has Error
  invalid,
}
