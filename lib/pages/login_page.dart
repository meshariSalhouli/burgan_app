import 'package:burgan_app/providers/auth_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:local_auth/local_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    usernameController.text = context.read<AuthProvider>().user?.username ?? "";
  }

  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate(BuildContext context) async {
    try {
      final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to autofill your credentials',
        options: const AuthenticationOptions(biometricOnly: false),
      );

      if (!didAuthenticate) return;
      await context.read<AuthProvider>().loginWithStoredCredentials();
      context.go('/mainscreen');
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Authentication failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("login"),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text("login "),
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
                  await context.read<AuthProvider>().login(
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
              child: const Text("login"),
            ),
            const SizedBox(height: 20), // Add some space
            if (context.read<AuthProvider>().isUserLoggedInBefore)
              ElevatedButton(
                onPressed: () => _authenticate(context), // Trigger Face ID
                child: const Text("Login with Face ID"),
              ),
          ],
        ),
      ),
    );
  }
}
