import 'package:burgan_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign up"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign Up"),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a username' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a email' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a password' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'ConfirmPassword'),
              controller: confirmPasswordController,
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  context.read<AuthProvider>().signup(
                        email: usernameController.text,
                        password: passwordController.text,
                      );
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('error')));
                }
                context.push('/mainscreen');
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
