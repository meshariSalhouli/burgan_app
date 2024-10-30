// // import 'package:burgan_app/pages/OffersPage.dart';
// // import 'package:burgan_app/pages/branches_page.dart';
// // import 'package:burgan_app/pages/home_page.dart';
// // import 'package:burgan_app/pages/login_page.dart';
// // import 'package:burgan_app/pages/profile_page.dart';
// // import 'package:burgan_app/pages/settings_page.dart';
// // import 'package:burgan_app/pages/sign_page.dart';
// // import 'package:burgan_app/pages/signup_page.dart';
// // import 'package:burgan_app/providers/auth_provider.dart';
// // import 'package:burgan_app/providers/bank_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:provider/provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// // import 'package:burgan_app/l10n/app_localizations.dart'; // Add this import

// // void main() {
// //   runApp(
// //     MultiProvider(
// //       providers: [
// //         ChangeNotifierProvider(create: (_) => Bankprovider()),
// //         ChangeNotifierProvider(create: (_) => AuthProvider()),
// //       ],
// //       child: MyApp(),
// //     ),
// //   );
// // }

// // class MyApp extends StatelessWidget {
// //   final GoRouter _router = GoRouter(
// //     initialLocation: '/',
// //     routes: [
// //       GoRoute(
// //         path: '/mainscreen',
// //         builder: (context, state) => MainScreen(),
// //       ),
// //       GoRoute(
// //         path: '/signup',
// //         builder: (context, state) => SignupPage(),
// //       ),
// //       GoRoute(
// //         path: '/login',
// //         builder: (context, state) => LoginPage(),
// //       ),
// //       GoRoute(
// //         path: '/',
// //         builder: (context, state) => SignPage(),
// //       ),
// //       GoRoute(
// //         path: '/profile',
// //         builder: (context, state) => const ProfilePage(),
// //       ),
// //       GoRoute(
// //         path: '/branchDetail',
// //         builder: (context, state) {
// //           final branch = state.extra as Branch;
// //           return BranchDetailPage(branch: branch);
// //         },
// //       ),
// //     ],
// //   );

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp.router(
// //       routerConfig: _router,
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class MainScreen extends StatefulWidget {
// //   @override
// //   _MainScreenState createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //   int _selectedIndex = 0;

// //   final List<Widget> _pages = [
// //     MainPage(),
// //     OffersPage(),
// //     ListScreen(),
// //     SettingsPage(),
// //   ];

// //   void _onItemTapped(int index) {
// //     setState(() {
// //       _selectedIndex = index;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: _pages[_selectedIndex], // Display selected page
// //       bottomNavigationBar: BottomNavigationBar(
// //         items: const <BottomNavigationBarItem>[
// //           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.local_offer), label: 'Offers'),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.location_on), label: 'Branches'),
// //           BottomNavigationBarItem(
// //               icon: Icon(Icons.settings), label: 'Settings'),
// //         ],
// //         currentIndex: _selectedIndex,
// //         selectedItemColor: const Color.fromARGB(182, 18, 1, 255),
// //         unselectedItemColor: Colors.grey,
// //         // type: BottomNavigationBarType.fixed,
// //         onTap: _onItemTapped,
// //       ),
// //     );
// //   }
// // }
// import 'package:burgan_app/pages/offersPage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:burgan_app/l10n/app_localizations.dart';
// import 'package:burgan_app/pages/branches_page.dart';
// import 'package:burgan_app/pages/home_page.dart';
// import 'package:burgan_app/pages/login_page.dart';
// import 'package:burgan_app/pages/offers_page.dart';
// import 'package:burgan_app/pages/profile_page.dart';
// import 'package:burgan_app/pages/settings_page.dart';
// import 'package:burgan_app/pages/sign_page.dart';
// import 'package:burgan_app/pages/signup_page.dart';
// import 'package:burgan_app/providers/auth_provider.dart';
// import 'package:burgan_app/providers/bank_provider.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => Bankprovider()),
//         ChangeNotifierProvider(create: (_) => AuthProvider()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   static void setLocale(BuildContext context, Locale newLocale) {
//     MyAppState state = context.findAncestorStateOfType<MyAppState>()!;
//     state.setLocale(newLocale);
//   }

//   @override
//   MyAppState createState() => MyAppState();
// }

// class MyAppState extends State<MyApp> {
//   Locale? locale;

//   void setLocale(Locale newLocale) {
//     setState(() {
//       locale = newLocale;
//     });
//   }

//   final GoRouter router = GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(
//         path: '/mainscreen',
//         builder: (context, state) => MainScreen(),
//       ),
//       GoRoute(
//         path: '/signup',
//         builder: (context, state) => SignupPage(),
//       ),
//       GoRoute(
//         path: '/login',
//         builder: (context, state) => LoginPage(),
//       ),
//       GoRoute(
//         path: '/',
//         builder: (context, state) => SignPage(),
//       ),
//       GoRoute(
//         path: '/profile',
//         builder: (context, state) => const ProfilePage(),
//       ),
//       GoRoute(
//         path: '/branchDetail',
//         builder: (context, state) {
//           final branch = state.extra as Branch;
//           return BranchDetailPage(branch: branch);
//         },
//       ),
//     ],
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       locale: locale,
//       routerConfig: router,
//       debugShowCheckedModeBanner: false,
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: [
//         Locale('en', ''), // English
//         Locale('ar', ''), // Arabic
//         Locale('hi', ''), // Hindi
//       ],
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   MainScreenState createState() => MainScreenState();
// }

// class MainScreenState extends State<MainScreen> {
//   int selectedIndex = 0;

//   final List<Widget> pages = [
//     MainPage(),
//     OffersPage(),
//     ListScreen(),
//     SettingsPage(),
//   ];

//   void onItemTapped(int index) {
//     setState(() {
//       selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pages[selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(icon: Icon(Icons.local_offer), label: 'Offers'),
//           BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Branches'),
//           BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
//         ],
//         currentIndex: selectedIndex,
//         selectedItemColor: const Color.fromARGB(182, 18, 1, 255),
//         unselectedItemColor: Colors.grey,
//         onTap: onItemTapped,
//       ),
//     );
//   }
// }
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
import 'translations.dart';

void main() async {
  final languageProvider = LanguageProvider();
  await languageProvider.loadLanguage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Bankprovider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
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
