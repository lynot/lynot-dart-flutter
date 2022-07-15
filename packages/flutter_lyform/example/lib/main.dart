import 'package:example/bloc_observer.dart';
import 'package:example/profile_form/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  await BlocOverrides.runZoned(
    () async => runApp(const App()),
    blocObserver: AppBlocObserver(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ProfilePage(),
    );
  }
}
