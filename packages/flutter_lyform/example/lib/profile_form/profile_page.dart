import 'package:example/profile_form/profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_lyform/flutter_lyform.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Form'),
      ),
      body: BlocProvider(
        create: (context) => ProfileForm(),
        child: const ProfileView(),
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormBlocListener<ProfileForm, String, String>(
      bloc: context.read<ProfileForm>(),
      onSuccess: (value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(value),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InputBlocBuilder<String>(
              bloc: context.read<ProfileForm>().email,
              builder: (context, state) {
                final bloc = context.read<ProfileForm>().email;
                return TextField(
                  onChanged: bloc.dirty,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: state.error,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            InputBlocBuilder<String>(
              bloc: context.read<ProfileForm>().name,
              builder: (context, state) {
                final bloc = context.read<ProfileForm>().name;
                return TextField(
                  onChanged: bloc.dirty,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    errorText: state.error,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            InputBlocBuilder<String?>(
              bloc: context.read<ProfileForm>().country,
              builder: (context, state) {
                final bloc = context.read<ProfileForm>().country;
                return TextField(
                  onChanged: bloc.dirty,
                  decoration: InputDecoration(
                    hintText: 'Country',
                    errorText: state.error,
                  ),
                );
              },
            ),
            InputBlocBuilder<int>(
              bloc: context.read<ProfileForm>().age,
              builder: (context, state) {
                final bloc = context.read<ProfileForm>().age;
                return TextField(
                  onChanged: (value) => bloc.dirty(int.parse(value)),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Age',
                    errorText: state.error,
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            FormBlocBuilder<ProfileForm>(
              bloc: context.read<ProfileForm>(),
              onLoading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              onValid: () => MaterialButton(
                color: Colors.blue,
                child: const Text('Save Profile'),
                onPressed: () {
                  context.read<ProfileForm>().submit();
                },
              ),
              orElse: () => MaterialButton(
                color: Colors.blueGrey,
                child: const Text('Save Profile'),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
