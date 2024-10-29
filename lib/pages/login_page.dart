import 'package:burgan_app/providers/auth_provider.dart';
import 'package:burgan_app/services/biometric_service.dart'; // Face ID
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
/*Convert LoginPage from a StatelessWidget to a StatefulWidget 
to handle the Face ID logic when the page loads.*/

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authenticateWithFaceID();
  }

  // Method to authenticate with Face ID if enabled
  Future<void> _authenticateWithFaceID() async {
    // Check if Face ID is enabled (use a shared preference or other storage for this)
    bool isFaceIDEnabled = await context.read<AuthProvider>().isFaceIDEnabled();

    if (isFaceIDEnabled) {
      bool isAuthenticated = await BiometricService().authenticateWithFaceID();

      if (isAuthenticated) {
        context.go(
            '/mainscreen'); // Navigate to main screen if Face ID is successful
      }
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
                  await context.read<AuthProvider>().loginWithCredentials(
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
            const SizedBox(height: 20),

            // Face ID Icon for quick authentication
            IconButton(
              icon: const Icon(Icons.face_retouching_natural,
                  size: 30, color: Colors.blueAccent),
              onPressed: () async {
                // Trigger Face ID authentication on icon tap
                _authenticateWithFaceID();
              },
              tooltip: 'Login with Face ID',
            ),
            const Text("Tap to use Face ID"),
          ],
        ),
      ),
    );
  }
}

// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//   final usernameController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("login"),
//       ),
//       resizeToAvoidBottomInset: false,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Text("login "),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Email'),
//               controller: usernameController,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter a username' : null,
//             ),
//             TextFormField(
//               decoration: const InputDecoration(hintText: 'Password'),
//               controller: passwordController,
//               obscureText: true,
//               validator: (value) =>
//                   value!.isEmpty ? 'Please enter a password' : null,
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 try {
//                   // wait for authentication
//                   await context.read<AuthProvider>().login(
//                       email: usernameController.text,
//                       password: passwordController.text);

//                   var user = context.read<AuthProvider>().user;
//                   print("You are logged in as ${user!.username}");
//                   context.go('/mainscreen');
//                 } on DioException catch (e) {
//                   if (e.response == null) return;
//                   if (e.response!.data == null) return;

//                   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                       content: Text(
//                           e.response!.data['message'] ?? "Unexpected error")));
//                 }
//               },
//               child: const Text("login"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
