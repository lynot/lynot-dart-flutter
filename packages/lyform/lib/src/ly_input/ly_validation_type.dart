part of 'ly_input.dart';

enum LyValidationType {
  /// Not validate the field
  none,

  /// Only validate the field when is drity
  explicit,

  /// Always validate the field
  always;

  bool get isNone => this == none;
  bool get isExplicit => this == explicit;
  bool get isAlways => this == always;
}
