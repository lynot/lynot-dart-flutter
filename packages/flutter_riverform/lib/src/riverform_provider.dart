import 'package:flutter/material.dart';
import 'package:flutter_riverform/flutter_riverform.dart';

class RiverformProvider extends InheritedWidget {
  const RiverformProvider({
    super.key,
    required this.form,
    required this.formId,
    required super.child,
  });

  final Riverform form;

  final String formId;

  static RiverformProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RiverformProvider>();
  }

  @override
  bool updateShouldNotify(RiverformProvider oldWidget) {
    return oldWidget.form != form || oldWidget.formId != formId;
  }
}
