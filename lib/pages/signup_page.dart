import 'package:burgan_app/providers/auth_provider.dart';
import 'package:dio/dio.dart';
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
              decoration: const InputDecoration(hintText: 'Email'),
              controller: usernameController,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a username' : null,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
              validator: (value) =>
                  value!.isEmpty ? 'Please enter a password' : null,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // wait for authentication
                  await context.read<AuthProvider>().signup(
                      email: usernameController.text,
                      password: passwordController.text);

                  var user = context.read<AuthProvider>().user;
                  print("You are logged in as ${user!.username}");
                  context.go('/mainscreen');
                } on DioException catch (e) {
                  if (e.response == null) return;
                  if (e.response!.data == null) return;

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          e.response!.data['message'] ?? "Unexpected error")));
                }
              },
              child: const Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
