import 'package:burgan_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SigninPage extends StatelessWidget {
  SigninPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("Sign In"),
            TextField(
              decoration: const InputDecoration(hintText: 'Username'),
              controller: usernameController,
            ),
            TextField(
              decoration: const InputDecoration(hintText: 'Password'),
              controller: passwordController,
              obscureText: true,
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
              child: const Text("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
