import 'package:flutter/material.dart';

extension TextEditing on TextEditingController {
  void setValue(String text) {
    value = TextEditingValue(text: text, selection: selection);
  }
}
