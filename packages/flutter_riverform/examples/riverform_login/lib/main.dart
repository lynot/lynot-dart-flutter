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
  defaultValue: '',
);
final registerForm = Riverform(
  inputs: [
    Rinput<String>(
      'name',
      defaultValue: '',
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
      defaultValue: '',
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
      defaultValue: '',
      validationMode: InputValidationMode.explicit,
      dependencies: [passwordInput.provider],
      validationTriggers: (formId) => [
        passwordInput.provider(formId).select((state) => state.value),
      ],
      validatorBuilder: (read, formId) {
        return CustomSyncValidator(
          (value) {
            return read(passwordInput.provider(formId)).value != value
                ? 'Password not match'
                : null;
          },
        );
      },
    ),
  ],
);

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
                initialValues: const {
                  'email': 'valid@email.com',
                  'password': 'gente',
                  'confirm_password': 'gente',
                },
                form: registerForm,
                formId: 'register',
                child: AutofillGroup(
                  child: Column(
                    children: [
                      RinputConsumer<String>(
                        inputId: 'name',
                        builder: (context, state, controller) {
                          return TextFormField(
                            onChanged: controller.update,
                            initialValue: state.value,
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
                        builder: (context, state, controller) {
                          return TextFormField(
                            onChanged: controller.update,
                            initialValue: state.value,
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
                        builder: (context, state, controller) {
                          return TextFormField(
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
                        builder: (context, state, controller) {
                          return TextFormField(
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
                        builder: (context, state, controller) {
                          return ElevatedButton(
                            onPressed: () {
                              controller.validate();
                            },
                            child: Text(
                                '${state.isPure ? 'Pure' : 'Changed'} - ${state.validState.name}'),
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
    print('''
{
  "provider": "${provider.name ?? provider.runtimeType}",
  "fomValue": "$previousValue"
  "newValue": "$newValue"
}''');
  }
}
