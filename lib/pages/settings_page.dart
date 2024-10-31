// // // ignore: unused_import
// // import 'package:burgan_app/main.dart';
// // import 'package:burgan_app/providers/auth_provider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';
// // import 'package:provider/provider.dart';
// // import 'package:burgan_app/translations.dart';
// // import 'package:burgan_app/providers/language_provider.dart';
// // import 'package:qr_flutter/qr_flutter.dart';

// // class SettingsPage extends StatefulWidget {
// //   @override
// //   _SettingsPageState createState() => _SettingsPageState();
// // }

// // class _SettingsPageState extends State<SettingsPage> {
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
// //     final languageProvider = Provider.of<LanguageProvider>(context);
// //     final selectedLanguage = languageProvider.languageCode;

// //     return Scaffold(
// //       appBar: AppBar(
// //         actions: [
// //           IconButton(
// //             onPressed: () {
// //               Provider.of<AuthProvider>(context, listen: false).logout();
// //               context.go("/");
// //             },
// //             icon: Icon(Icons.logout),
// //             color: Colors.red,
// //           ),
// //         ],
// //         title: Text(Translations.get('settingsTitle', selectedLanguage)),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             // QR Code Section
// //             const Text(
// //               "Your QR Code",
// //               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 10),
// //             QrImageView(
// //               data: '{"name": "Hamad", "iban": "1234567890"}',
// //               version: QrVersions.auto,
// //               size: 200.0,
// //             ),
// //             const Divider(height: 30),

// //             // Updated Currency Converter Section
// //             Text(
// //               Translations.get('currencyConverter', selectedLanguage),
// //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
// //             ),
// //             SizedBox(height: 15),
// //             Container(
// //               padding: const EdgeInsets.all(16.0),
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade50,
// //                 borderRadius: BorderRadius.circular(20),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.shade300,
// //                     blurRadius: 10,
// //                     offset: Offset(0, 10),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 children: [
// //                   Row(
// //                     children: [
// //                       Expanded(
// //                         child: Column(
// //                           children: [
// //                             const Text(
// //                               'From',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w500,
// //                                 fontSize: 18,
// //                               ),
// //                             ),
// //                             DropdownButton<String>(
// //                               value: fromCurrency,
// //                               isExpanded: true,
// //                               items: currencies.map((String value) {
// //                                 return DropdownMenuItem<String>(
// //                                   value: value,
// //                                   child: Text(value),
// //                                 );
// //                               }).toList(),
// //                               onChanged: (newValue) {
// //                                 setState(() {
// //                                   fromCurrency = newValue!;
// //                                 });
// //                               },
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                       const SizedBox(width: 20),
// //                       Expanded(
// //                         child: Column(
// //                           children: [
// //                             const Text(
// //                               'To',
// //                               style: TextStyle(
// //                                 fontWeight: FontWeight.w500,
// //                                 fontSize: 18,
// //                               ),
// //                             ),
// //                             DropdownButton<String>(
// //                               value: toCurrency,
// //                               isExpanded: true,
// //                               items: currencies.map((String value) {
// //                                 return DropdownMenuItem<String>(
// //                                   value: value,
// //                                   child: Text(value),
// //                                 );
// //                               }).toList(),
// //                               onChanged: (newValue) {
// //                                 setState(() {
// //                                   toCurrency = newValue!;
// //                                 });
// //                               },
// //                             ),
// //                           ],
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                   const SizedBox(height: 15),
// //                   TextField(
// //                     controller: amountController,
// //                     keyboardType: TextInputType.number,
// //                     decoration: InputDecoration(
// //                       labelText:
// //                           Translations.get('enterAmount', selectedLanguage),
// //                       border: OutlineInputBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 15),
// //                   ElevatedButton.icon(
// //                     style: ElevatedButton.styleFrom(
// //                       padding: const EdgeInsets.symmetric(
// //                           horizontal: 20, vertical: 12),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(10),
// //                       ),
// //                     ),
// //                     onPressed: convertCurrency,
// //                     icon: const Icon(Icons.currency_exchange),
// //                     label: Text(Translations.get('convert', selectedLanguage)),
// //                   ),
// //                   const SizedBox(height: 15),
// //                   Text(
// //                     result,
// //                     style: TextStyle(
// //                       fontSize: 18,
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.blueAccent,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const Divider(height: 30),

// //             // Language Selector Section with Flags
// //             Text(
// //               Translations.get('language', selectedLanguage),
// //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 10),
// //             Container(
// //               padding: const EdgeInsets.symmetric(horizontal: 12),
// //               decoration: BoxDecoration(
// //                 color: Colors.blue.shade50,
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: DropdownButton<String>(
// //                 value: selectedLanguage,
// //                 isExpanded: true,
// //                 underline: Container(),
// //                 items: const [
// //                   DropdownMenuItem(
// //                     value: 'en',
// //                     child: Row(
// //                       children: [
// //                         Image(
// //                           image: AssetImage('assets/images/uk_flag.png'),
// //                           width: 24,
// //                         ),
// //                         SizedBox(width: 8),
// //                         Text('English'),
// //                       ],
// //                     ),
// //                   ),
// //                   DropdownMenuItem(
// //                     value: 'ar',
// //                     child: Row(
// //                       children: [
// //                         Image(
// //                           image: AssetImage('assets/images/kuwait_flag.png'),
// //                           width: 24,
// //                         ),
// //                         SizedBox(width: 8),
// //                         Text('Arabic'),
// //                       ],
// //                     ),
// //                   ),
// //                   DropdownMenuItem(
// //                     value: 'hi',
// //                     child: Row(
// //                       children: [
// //                         Image(
// //                           image: AssetImage('assets/images/india_flag.png'),
// //                           width: 24,
// //                         ),
// //                         SizedBox(width: 8),
// //                         Text('Hindi'),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //                 onChanged: (newValue) {
// //                   if (newValue != null) {
// //                     languageProvider.setLanguage(newValue);
// //                   }
// //                 },
// //               ),
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
// // ignore: unused_import
// import 'package:burgan_app/main.dart';
// import 'package:burgan_app/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:burgan_app/translations.dart';
// import 'package:burgan_app/providers/language_provider.dart';
// import 'package:qr_flutter/qr_flutter.dart';

// class SettingsPage extends StatefulWidget {
//   @override
//   _SettingsPageState createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
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
//     final languageProvider = Provider.of<LanguageProvider>(context);
//     final selectedLanguage = languageProvider.languageCode;

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               Provider.of<AuthProvider>(context, listen: false).logout();
//               context.go("/");
//             },
//             icon: Icon(Icons.logout),
//             color: Colors.red,
//           ),
//         ],
//         title: Text(Translations.get('settingsTitle', selectedLanguage)),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             // QR Code Section inside a dark container
//             const Text(
//               "Your QR Code",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.all(20),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//               child: QrImageView(
//                 data: '{"name": "Hamad", "iban": "1234567890"}',
//                 version: QrVersions.auto,
//                 size: 200.0,
//                 backgroundColor: Colors.white, // Ensures visibility
//               ),
//             ),
//             const Divider(height: 30),

//             // Updated Currency Converter Section
//             Text(
//               Translations.get('currencyConverter', selectedLanguage),
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 15),
//             Container(
//               padding: const EdgeInsets.all(16.0),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.shade300,
//                     blurRadius: 10,
//                     offset: Offset(0, 10),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const Text(
//                               'From',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             DropdownButton<String>(
//                               value: fromCurrency,
//                               isExpanded: true,
//                               items: currencies.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   fromCurrency = newValue!;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Expanded(
//                         child: Column(
//                           children: [
//                             const Text(
//                               'To',
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 18,
//                               ),
//                             ),
//                             DropdownButton<String>(
//                               value: toCurrency,
//                               isExpanded: true,
//                               items: currencies.map((String value) {
//                                 return DropdownMenuItem<String>(
//                                   value: value,
//                                   child: Text(value),
//                                 );
//                               }).toList(),
//                               onChanged: (newValue) {
//                                 setState(() {
//                                   toCurrency = newValue!;
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 15),
//                   TextField(
//                     controller: amountController,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       labelText:
//                           Translations.get('enterAmount', selectedLanguage),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15),
//                   ElevatedButton.icon(
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 20, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     onPressed: convertCurrency,
//                     icon: const Icon(Icons.currency_exchange),
//                     label: Text(Translations.get('convert', selectedLanguage)),
//                   ),
//                   const SizedBox(height: 15),
//                   Text(
//                     result,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Divider(height: 30),

//             // Language Selector Section with Flags
//             Text(
//               Translations.get('language', selectedLanguage),
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: Colors.blue.shade50,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: DropdownButton<String>(
//                 value: selectedLanguage,
//                 isExpanded: true,
//                 underline: Container(),
//                 items: const [
//                   DropdownMenuItem(
//                     value: 'en',
//                     child: Row(
//                       children: [
//                         Image(
//                           image: AssetImage('assets/images/uk_flag.png'),
//                           width: 24,
//                         ),
//                         SizedBox(width: 8),
//                         Text('English'),
//                       ],
//                     ),
//                   ),
//                   DropdownMenuItem(
//                     value: 'ar',
//                     child: Row(
//                       children: [
//                         Image(
//                           image: AssetImage('assets/images/kuwait_flag.png'),
//                           width: 24,
//                         ),
//                         SizedBox(width: 8),
//                         Text('Arabic'),
//                       ],
//                     ),
//                   ),
//                   DropdownMenuItem(
//                     value: 'hi',
//                     child: Row(
//                       children: [
//                         Image(
//                           image: AssetImage('assets/images/india_flag.png'),
//                           width: 24,
//                         ),
//                         SizedBox(width: 8),
//                         Text('Hindi'),
//                       ],
//                     ),
//                   ),
//                 ],
//                 onChanged: (newValue) {
//                   if (newValue != null) {
//                     languageProvider.setLanguage(newValue);
//                   }
//                 },
//               ),
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
// ignore: unused_import
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
    final languageProvider = Provider.of<LanguageProvider>(context);
    final selectedLanguage = languageProvider.languageCode;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade800,
        title: Text(
          Translations.get('More'.tr, selectedLanguage),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<AuthProvider>(context, listen: false).logout();
              context.go("/");
            },
            icon: Icon(Icons.logout,
                color: const Color.fromARGB(255, 255, 234, 234)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // QR Code Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your QR Code",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade50,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: QrImageView(
                        data: '{"name": "Hamad", "iban": "1234567890"}',
                        version: QrVersions.auto,
                        size: 180.0,
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Currency Converter Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translations.get('currencyConverter', selectedLanguage),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "From",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText: "To",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText:
                          Translations.get('enterAmount', selectedLanguage),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.indigo.shade600,
                      ),
                      onPressed: convertCurrency,
                      icon: const Icon(Icons.currency_exchange,
                          color: Colors.white),
                      label: Text(
                        Translations.get('convert', selectedLanguage),
                        style: const TextStyle(
                            color: Colors
                                .white), // Ensure label text is also white
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    result,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Language Selector Section with Flags
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Translations.get('language', selectedLanguage),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.indigo.shade50,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    value: selectedLanguage,
                    items: const [
                      DropdownMenuItem(
                        value: 'en',
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/uk_flag.png'),
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text('English'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'ar',
                        child: Row(
                          children: [
                            Image(
                              image:
                                  AssetImage('assets/images/kuwait_flag.png'),
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Arabic'),
                          ],
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'hi',
                        child: Row(
                          children: [
                            Image(
                              image: AssetImage('assets/images/india_flag.png'),
                              width: 24,
                            ),
                            SizedBox(width: 8),
                            Text('Hindi'),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (newValue) {
                      if (newValue != null) {
                        languageProvider.setLanguage(newValue);
                      }
                    },
                  ),
                ],
              ),
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
