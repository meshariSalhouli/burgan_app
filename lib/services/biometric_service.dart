import 'package:local_auth/local_auth.dart';

class BiometricService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> authenticateWithFaceID() async {
    bool isAuthenticated = await _auth.authenticate(
      localizedReason: 'Please authenticate to access your account',
      options: const AuthenticationOptions(
        useErrorDialogs: true,
        stickyAuth: true,
      ),
    );
    return isAuthenticated;
  }
}
