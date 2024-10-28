import 'package:burgan_app/pages/OffersPage.dart';
import 'package:burgan_app/pages/branches_page.dart';
import 'package:burgan_app/pages/home_page.dart';
import 'package:burgan_app/pages/profile_page.dart';
import 'package:burgan_app/pages/settings_page.dart';
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
  final GoRouter _router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/mainscreen',
        builder: (context, state) => MainScreen(),
      ),
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
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    MainPage(),
    OffersPage(),
    BranchesPage(),
    SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_offer), label: 'Offers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on), label: 'Branches'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(182, 18, 1, 255),
        unselectedItemColor: Colors.grey,
        // type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    );
  }
}
