import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverform/flutter_riverform.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      observers: [Logger()],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const RegisterPage(),
      ),
    );
  }
}

typedef RiverformBuilder = Riverform Function(String formId);

final passwordInput = Rinput<String>(
  'password',
);
final registerForm = Riverform(
  inputs: [
    Rinput<String>(
      'name',
      validatorBuilder: (read, formId) {
        return CustomAsyncValidator(
          (value) async {
            await Future.delayed(const Duration(seconds: 2));
            return value == 'Name' ? null : '"$value" is already used';
          },
        );
      },
    ),
    Rinput<String>(
      'email',
      validatorBuilder: (read, formId) {
        return CustomAsyncValidator(
          (value) async {
            await Future.delayed(const Duration(seconds: 2));
            return value == 'valid@email.com'
                ? null
                : 'The email is already used';
          },
        );
      },
    ),
    passwordInput,
    Rinput<String>(
      'confirm_password',
      validationMode: InputValidationMode.explicit,
      dependencies: [passwordInput.provider],
      validationTriggers: (formId) => [
        passwordInput.provider(formId).select((state) => state.value),
      ],
      validatorBuilder: (ref, formId) {
        return CustomSyncValidator(
          (value) {
            return ref.read(passwordInput.provider(formId)).value != value
                ? 'Password not match'
                : null;
          },
        );
      },
    ),
  ],
);

RiverformController controller = RiverformController();

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
              width: 300,
              child: RiverformScope(
                formId: 'register',
                controller: controller,
                initialValues: const {
                  'name': '',
                  'email': 'valid@email.com',
                  'password': 'gente',
                  'confirm_password': 'gente',
                },
                form: registerForm,
                child: AutofillGroup(
                  child: Column(
                    children: [
                      RinputConsumer<String>(
                        inputId: 'name',
                        builder: (context, ref, state, controller) {
                          print(controller.key);
                          return TextFormField(
                            key: controller.key,
                            initialValue: state.value,
                            onChanged: controller.update,
                            autofillHints: const [AutofillHints.name],
                            decoration: InputDecoration(
                              label: const Text('Name'),
                              errorText: state.error,
                            ),
                          );
                        },
                      ),
                      RinputConsumer<String>(
                        inputId: 'email',
                        builder: (context, ref, state, controller) {
                          return TextFormField(
                            key: controller.key,
                            initialValue: state.value,
                            onChanged: controller.update,
                            autofillHints: const [AutofillHints.email],
                            decoration: InputDecoration(
                              label: const Text('Email'),
                              errorText: state.error,
                            ),
                          );
                        },
                      ),
                      RinputConsumer<String>(
                        inputId: 'password',
                        builder: (context, ref, state, controller) {
                          return TextFormField(
                            key: controller.key,
                            initialValue: state.value,
                            onChanged: controller.update,
                            decoration: InputDecoration(
                              label: const Text('Password'),
                              errorText: state.error,
                            ),
                          );
                        },
                      ),
                      RinputConsumer<String>(
                        inputId: 'confirm_password',
                        builder: (context, ref, state, controller) {
                          return TextFormField(
                            key: controller.key,
                            initialValue: state.value,
                            onChanged: controller.update,
                            onFieldSubmitted: (_) => controller.validate(),
                            decoration: InputDecoration(
                              label: const Text('Confirm Password'),
                              errorText: state.error,
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      RiverformConsumer(
                        builder: (context, ref, state) {
                          return Row(
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  await controller.validate();
                                },
                                child: Text(
                                    '${state.isPure ? 'Pure' : 'Changed'} - ${state.validState.name}'),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  controller.reset();
                                },
                                child: const Text('Reset'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

class Logger extends ProviderObserver {
  // @override
  // void didDisposeProvider(ProviderBase provider, ProviderContainer container) {
  //    log(' Dispose: ${provider.name} on ${container.})
  // }

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "fomValue": "$previousValue"
  "newValue": "$newValue"
}''');
  }
}
