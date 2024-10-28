import 'package:burgan_app/pages/home_page.dart';
import 'package:burgan_app/pages/profile_page.dart';
import 'package:burgan_app/pages/sign_page.dart';
import 'package:burgan_app/pages/signin_page.dart';
import 'package:burgan_app/pages/signup_page.dart';
import 'package:burgan_app/providers/auth_provider.dart';
import 'package:burgan_app/providers/bank_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bankprovider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }

  final _router = GoRouter(routes: [
    GoRoute(
      path: '/signup',
      builder: (context, state) => SignupPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => SigninPage(),
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => const SignPage(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const Homepage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
  ]);
}
