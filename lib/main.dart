import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:burgan_app/pages/branches_page.dart';
import 'package:burgan_app/pages/home_page.dart';
import 'package:burgan_app/pages/login_page.dart';
import 'package:burgan_app/pages/offersPage.dart';
import 'package:burgan_app/pages/profile_page.dart';
import 'package:burgan_app/pages/settings_page.dart';
import 'package:burgan_app/pages/sign_page.dart';
import 'package:burgan_app/pages/signup_page.dart';
import 'package:burgan_app/providers/auth_provider.dart';
import 'package:burgan_app/providers/bank_provider.dart';
import 'package:burgan_app/providers/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final languageProvider = LanguageProvider();
  final authProvider = AuthProvider();

  await Future.wait([
    languageProvider.loadLanguage(),
    authProvider.loadPreviousUser(),
  ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bankprovider()),
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => languageProvider),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GoRouter router = GoRouter(
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
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => SignPage(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: '/branchDetail',
        builder: (context, state) {
          final branch = state.extra as Branch;
          return BranchDetailPage(branch: branch);
        },
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    final languageCode = context.watch<LanguageProvider>().languageCode;

    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      locale: Locale(languageCode),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en', ''),
        Locale('ar', ''),
        Locale('hi', ''),
      ],

      // localeResolutionCallback: (locale, supportedLocales) {
      //   for (var supportedLocale in supportedLocales) {
      //     if (supportedLocale.languageCode == locale?.languageCode) {
      //       return supportedLocale;
      //     }
      //   }
      //   return supportedLocales.first;
      // },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    MainPage(),
    OffersPage(),
    ListScreen(),
    SettingsPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
        currentIndex: selectedIndex,
        selectedItemColor: const Color.fromARGB(182, 18, 1, 255),
        unselectedItemColor: Colors.grey,
        onTap: onItemTapped,
      ),
    );
  }
}
