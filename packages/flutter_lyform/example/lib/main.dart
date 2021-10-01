import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: FormWidget()),
      ),
    );
  }
}

class FormWidget extends StatelessWidget {
  FormWidget({
    Key? key,
  }) : super(key: key);

  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ExampleForm>(
      create: (context) => ExampleForm(),
      child: Builder(builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputBlocBuilder<String>(
                bloc: context.read<ExampleForm>().name,
                builder: (context, state) {
                  final bloc = context.read<ExampleForm>().name;
                  return TextField(
                    controller: nameController..setValue(state.value),
                    onChanged: bloc.dirty,
                    decoration: const InputDecoration(labelText: 'Name'),
                  );
                },
              ),
              FormBlocBuilder<ExampleForm>(
                onValid: () => TextButton(
                  child: const Text('Submit'),
                  onPressed: () {},
                ),
                orElse: () => const TextButton(
                  child: Text('Submit'),
                  onPressed: null,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class ExampleForm extends FormBloc<String, String> {
  final name = InputBloc<String>(
    pureValue: '',
    validationType: ValidationType.none,
  );

  @override
  List<InputBloc> get inputs => [name];

  @override
  Future<FormBlocState<String, String>> onSubmmit() async {
    return const FormSuccessState('Yeah!');
  }
}
