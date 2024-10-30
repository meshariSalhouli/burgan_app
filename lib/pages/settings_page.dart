// // import 'package:flutter/material.dart';
// // import 'package:provider/provider.dart';
// // import 'package:burgan_app/translations.dart';
// // import 'package:burgan_app/providers/language_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:qr_flutter/qr_flutter.dart';

// // class SettingsPage extends StatefulWidget {
// //   @override
// //   _SettingsPageState createState() => _SettingsPageState();
// // }

// // class _SettingsPageState extends State<SettingsPage> {
// //   // Currency Converter Variables
// //   final List<String> currencies = ['KWD', 'USD', 'EUR', 'INR'];
// //   String fromCurrency = 'KWD';
// //   String toCurrency = 'USD';
// //   final Map<String, Map<String, double>> conversionRates = {
// //     'KWD': {'USD': 3.30, 'EUR': 2.79, 'INR': 273.84, 'KWD': 1.0},
// //     'USD': {'KWD': 0.30, 'EUR': 0.85, 'INR': 83.0, 'USD': 1.0},
// //     'EUR': {'KWD': 0.36, 'USD': 1.18, 'INR': 97.0, 'EUR': 1.0},
// //     'INR': {'KWD': 0.0037, 'USD': 0.012, 'EUR': 0.010, 'INR': 1.0},
// //   };
// //   TextEditingController amountController = TextEditingController();
// //   String result = '';

// //   @override
// //   Widget build(BuildContext context) {
// //     // Access the language code directly from the provider
// //     final languageProvider = Provider.of<LanguageProvider>(context);
// //     final selectedLanguage = languageProvider.languageCode;

// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(Translations.get('settingsTitle', selectedLanguage)),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             Text(
// //               Translations.get('currencyConverter', selectedLanguage),
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 10),
// //             DropdownButton<String>(
// //               value: fromCurrency,
// //               items: currencies.map((String value) {
// //                 return DropdownMenuItem<String>(
// //                   value: value,
// //                   child: Text(value),
// //                 );
// //               }).toList(),
// //               onChanged: (newValue) {
// //                 setState(() {
// //                   fromCurrency = newValue!;
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 10),
// //             DropdownButton<String>(
// //               value: toCurrency,
// //               items: currencies.map((String value) {
// //                 return DropdownMenuItem<String>(
// //                   value: value,
// //                   child: Text(value),
// //                 );
// //               }).toList(),
// //               onChanged: (newValue) {
// //                 setState(() {
// //                   toCurrency = newValue!;
// //                 });
// //               },
// //             ),
// //             const SizedBox(height: 10),
// //             TextField(
// //               controller: amountController,
// //               keyboardType: TextInputType.number,
// //               decoration: InputDecoration(
// //                 labelText: Translations.get('enterAmount', selectedLanguage),
// //                 border: OutlineInputBorder(),
// //               ),
// //             ),
// //             const SizedBox(height: 10),
// //             ElevatedButton(
// //               onPressed: convertCurrency,
// //               child: Text(Translations.get('convert', selectedLanguage)),
// //             ),
// //             const SizedBox(height: 10),
// //             Text(
// //               result,
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const Divider(height: 30),

// //             // Language Selector Section
// //             Text(
// //               Translations.get('language', selectedLanguage),
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 10),
// //             DropdownButton<String>(
// //               value: selectedLanguage,
// //               items: [
// //                 DropdownMenuItem(value: 'en', child: Text('English')),
// //                 DropdownMenuItem(value: 'ar', child: Text('Arabic')),
// //                 DropdownMenuItem(value: 'hi', child: Text('Hindi')),
// //               ],
// //               onChanged: (newValue) {
// //                 if (newValue != null) {
// //                   languageProvider
// //                       .setLanguage(newValue); // Update language in provider
// //                 }
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   void convertCurrency() {
// //     final amount = double.tryParse(amountController.text);
// //     if (amount != null) {
// //       final rate = conversionRates[fromCurrency]?[toCurrency] ?? 0.0;
// //       if (rate > 0) {
// //         final convertedAmount = amount * rate;
// //         setState(() {
// //           result = '$amount $fromCurrency = $convertedAmount $toCurrency';
// //         });
// //       } else {
// //         setState(() {
// //           result = Translations.get(
// //               'conversionRateUnavailable',
// //               Provider.of<LanguageProvider>(context, listen: false)
// //                   .languageCode);
// //         });
// //       }
// //     } else {
// //       setState(() {
// //         result = Translations.get('invalidAmount',
// //             Provider.of<LanguageProvider>(context, listen: false).languageCode);
// //       });
// //     }
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:burgan_app/translations.dart';
// import 'package:burgan_app/providers/language_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   // Currency Converter Variables
//   final List<String> currencies = ['KWD', 'USD', 'EUR', 'INR'];
//   String fromCurrency = 'KWD';
//   String toCurrency = 'USD';
//   final Map<String, Map<String, double>> conversionRates = {
//     'KWD': {'USD': 3.30, 'EUR': 2.79, 'INR': 273.84, 'KWD': 1.0},
//     'USD': {'KWD': 0.30, 'EUR': 0.85, 'INR': 83.0, 'USD': 1.0},
//     'EUR': {'KWD': 0.36, 'USD': 1.18, 'INR': 97.0, 'EUR': 1.0},
//     'INR': {'KWD': 0.0037, 'USD': 0.012, 'EUR': 0.010, 'INR': 1.0},
//   };
//   TextEditingController amountController = TextEditingController();
//   String result = '';

//   @override
//   Widget build(BuildContext context) {
//     // Access the language code directly from the provider
//     final languageProvider = Provider.of<LanguageProvider>(context);
//     final selectedLanguage = languageProvider.languageCode;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(Translations.get('settingsTitle', selectedLanguage)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // QR Code Section
//             const Text(
//               "Your QR Code",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             QrImageView(
//               data: '{"name": "Hamad", "iban": "1234567890"}',
//               version: QrVersions.auto,
//               size: 200.0,
//             ),
//             const Divider(height: 30), // Separator between sections

//             // Currency Converter Section
//             Text(
//               Translations.get('currencyConverter', selectedLanguage),
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             DropdownButton<String>(
//               value: fromCurrency,
//               items: currencies.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   fromCurrency = newValue!;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             DropdownButton<String>(
//               value: toCurrency,
//               items: currencies.map((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//               onChanged: (newValue) {
//                 setState(() {
//                   toCurrency = newValue!;
//                 });
//               },
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               controller: amountController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: Translations.get('enterAmount', selectedLanguage),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: convertCurrency,
//               child: Text(Translations.get('convert', selectedLanguage)),
//             ),
//             const SizedBox(height: 10),
//             Text(
//               result,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const Divider(height: 30),

//             // Language Selector Section
//             Text(
//               Translations.get('language', selectedLanguage),
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             DropdownButton<String>(
//               value: selectedLanguage,
//               items: [
//                 DropdownMenuItem(value: 'en', child: Text('English')),
//                 DropdownMenuItem(value: 'ar', child: Text('Arabic')),
//                 DropdownMenuItem(value: 'hi', child: Text('Hindi')),
//               ],
//               onChanged: (newValue) {
//                 if (newValue != null) {
//                   languageProvider
//                       .setLanguage(newValue); // Update language in provider
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void convertCurrency() {
//     final amount = double.tryParse(amountController.text);
//     if (amount != null) {
//       final rate = conversionRates[fromCurrency]?[toCurrency] ?? 0.0;
//       if (rate > 0) {
//         final convertedAmount = amount * rate;
//         setState(() {
//           result = '$amount $fromCurrency = $convertedAmount $toCurrency';
//         });
//       } else {
//         setState(() {
//           result = Translations.get(
//               'conversionRateUnavailable',
//               Provider.of<LanguageProvider>(context, listen: false)
//                   .languageCode);
//         });
//       }
//     } else {
//       setState(() {
//         result = Translations.get('invalidAmount',
//             Provider.of<LanguageProvider>(context, listen: false).languageCode);
//       });
//     }
//   }
// }
import 'package:burgan_app/main.dart';
import 'package:burgan_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:burgan_app/translations.dart';
import 'package:burgan_app/providers/language_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Currency Converter Variables
  final List<String> currencies = ['KWD', 'USD', 'EUR', 'INR'];
  String fromCurrency = 'KWD';
  String toCurrency = 'USD';
  final Map<String, Map<String, double>> conversionRates = {
    'KWD': {'USD': 3.30, 'EUR': 2.79, 'INR': 273.84, 'KWD': 1.0},
    'USD': {'KWD': 0.30, 'EUR': 0.85, 'INR': 83.0, 'USD': 1.0},
    'EUR': {'KWD': 0.36, 'USD': 1.18, 'INR': 97.0, 'EUR': 1.0},
    'INR': {'KWD': 0.0037, 'USD': 0.012, 'EUR': 0.010, 'INR': 1.0},
  };
  TextEditingController amountController = TextEditingController();
  String result = '';

  @override
  Widget build(BuildContext context) {
    // Access the language code directly from the provider
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.languageCode;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              context.go("/");
            },
            icon: Icon(Icons.logout),
            color: Colors.red,
          )
        ],
        title: Text(Translations.get('settingsTitle', selectedLanguage)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // QR Code Section
            const Text(
              "Your QR Code",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            QrImageView(
              data: '{"name": "Hamad", "iban": "1234567890"}',
              version: QrVersions.auto,
              size: 200.0,
            ),
            const Divider(height: 30), // Separator between sections

            // Currency Converter Section
            Text(
              Translations.get('currencyConverter', selectedLanguage),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: fromCurrency,
              items: currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  fromCurrency = newValue!;
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: toCurrency,
              items: currencies.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  toCurrency = newValue!;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: Translations.get('enterAmount', selectedLanguage),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text(Translations.get('convert', selectedLanguage)),
            ),
            const SizedBox(height: 10),
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),

            // Language Selector Section
            Text(
              Translations.get('language', selectedLanguage),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedLanguage,
              items: [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ar', child: Text('Arabic')),
                DropdownMenuItem(value: 'hi', child: Text('Hindi')),
              ],
              onChanged: (newValue) {
                if (newValue != null) {
                  languageProvider
                      .setLanguage(newValue); // Update language in provider
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void convertCurrency() {
    final amount = double.tryParse(amountController.text);
    if (amount != null) {
      final rate = conversionRates[fromCurrency]?[toCurrency] ?? 0.0;
      if (rate > 0) {
        final convertedAmount = amount * rate;
        setState(() {
          result = '$amount $fromCurrency = $convertedAmount $toCurrency';
        });
      } else {
        setState(() {
          result = Translations.get(
              'conversionRateUnavailable',
              Provider.of<LanguageProvider>(context, listen: false)
                  .languageCode);
        });
      }
    } else {
      setState(() {
        result = Translations.get('invalidAmount',
            Provider.of<LanguageProvider>(context, listen: false).languageCode);
      });
    }
  }
}
