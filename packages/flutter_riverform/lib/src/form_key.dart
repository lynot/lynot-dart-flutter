import 'package:flutter_riverpod/flutter_riverpod.dart';

final riverformKey = StateProvider.family<int, String>(
  (ref, formId) {
    return 0;
  },
);
