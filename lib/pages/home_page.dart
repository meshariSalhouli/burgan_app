import 'package:animated_number/animated_number.dart';
import 'package:burgan_app/main.dart';
import 'package:burgan_app/models/account.dart';
import 'package:speech_to_text/speech_recognition_result.dart'; // Add this line if missing

import 'package:burgan_app/models/card.dart';
import 'package:burgan_app/models/transaction.dart';
import 'package:burgan_app/models/transactiontile.dart';
import 'package:burgan_app/providers/accounts_provider.dart';
import 'package:burgan_app/providers/auth_provider.dart';
import 'package:burgan_app/providers/cards_provider.dart';
import 'package:burgan_app/providers/language_provider.dart';
import 'package:burgan_app/services/account_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:convert'; // for decoding JSON from QR data
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

bool isProcessingText = false;

class _MainPageState extends State<MainPage> {
  double balance = 0.0;
  List<Transaction> transactions = []; // List to hold transaction history
  File? _profileImage; // Profile picture state
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // QR Key for QR scanner
  QRViewController? qrController; // QR Controller for handling scanner
  TextEditingController amountController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();

  Account? _selectedAccount;

  // Speech-to-text instance and state variables
  late stt.SpeechToText _speechToText;
  bool _speechEnabled = false;
  String _lastWords = '';

  // Initialize Speech-to-text
  @override
  void initState() {
    super.initState();
    context.read<Accountprovider>().get();
    context.read<BankCardProvider>().get();
    _speechToText = stt.SpeechToText();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (isProcessingText) return;
    isProcessingText = true;

    try {
      setState(() {
        _lastWords = result.recognizedWords;
      });
      // Check the recognized command and trigger actions
      if (_lastWords.toLowerCase().contains("check balance")) {
        _showBalancePopup();
        // } else if (_lastWords.toLowerCase().contains("transfer")) {
        //   _showTransferDialog(context.read<Accountprovider>().accounts.first.id);
      } else if (_lastWords.toLowerCase().contains("deposit")) {
        _showDepositDialog(context.read<Accountprovider>().accounts.first.id);
      } else if (_lastWords.toLowerCase().contains("withdraw")) {
        _showWithdrawDialog(context.read<Accountprovider>().accounts.first.id);
      }
    } finally {
      isProcessingText = false;
    }
  }

  BuildContext? previousExist = null;
  // Show balance popup when command is recognized
  void _showBalancePopup() {
    if (previousExist != null) {
      return;
      //Navigator.of(previousExist!).pop();
    }
    showDialog(
      context: context,
      builder: (context) {
        previousExist = context;
        return AlertDialog(
          title: Text("Balance"),
          content: Text(
              "Your current balance is ${context.read<Accountprovider>().balance} KWD."),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                previousExist = null;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to get greeting based on the time of day
  String _getGreeting(String name) {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "${'goodMorning'.tr}, $name";
    } else if (hour < 17) {
      return "${'Good Afternoon'.tr}$name,";
    } else {
      return "${'GoodEvening'.tr}, $name";
    }
  }

// SnackBar for insufficient funds
  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// Method to scan QR code and autofill transfer fields
  Future<void> _scanQRCode() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Scan QR Code")),
          body: QRView(
            key: qrKey,
            onQRViewCreated: (QRViewController controller) {
              setState(() {
                qrController = controller;
              });
              controller.scannedDataStream.listen((scanData) {
                controller.pauseCamera();
                final decodedData = jsonDecode(scanData.code ?? '{}');
                final name = decodedData['name'];
                final iban = decodedData['iban'];

                // Autofill the transfer details
                recipientNameController.text = name ?? '';
                ibanController.text = iban ?? '';

                Navigator.of(context).pop(); // Close the scanner view
              });
            },
          ),
        ),
      ),
    );
    qrController?.dispose();
  }

//
//
  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext _c) {
    return Scaffold(
      floatingActionButton: // Step 4: Add the button to start/stop speech recognition
          FloatingActionButton(
        onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
        tooltip: 'Voice Command',
        child:
            Icon(_speechToText.isNotListening ? Icons.mic_none : Icons.mic_off),
      ),
      appBar: AppBar(
        title: Text("Burgan Wallet".tr,
            style: TextStyle(
                fontSize: 22, color: const Color.fromARGB(255, 68, 138, 255))),
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         var account = await AccountServices.list();
        //         for (var a in account) {
        //           print(a);
        //         }

        //         var accountto =
        //             await AccountServices.transfer(7, 100, "1009358916");
        //         print(accountto);
        //       },
        //       icon: Icon(Icons.import_contacts))
        // ],
      ),
      body: Consumer<BankCardProvider>(builder: (context, cardProvider, _) {
        var cards = context.watch<BankCardProvider>().cards;

        return RefreshIndicator(
          onRefresh: () => Future.wait(
            [
              _c.read<Accountprovider>().get(),
              _c.read<BankCardProvider>().get(),
            ],
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              radius: 30,
                              backgroundImage: _profileImage != null
                                  ? NetworkImage(_profileImage!.path)
                                  : AssetImage('assets/images/download.png')
                                      as ImageProvider,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getGreeting(context
                                    .read<Accountprovider>()
                                    .accounts
                                    .first
                                    .name),
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Balance and Portfolio section
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            var card = cards[index];

                            var account = context
                                .read<Accountprovider>()
                                .accounts
                                .firstWhere((a) => a.id == card.accountId);

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SizedBox(
                                    width: 360,
                                    height: 226,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        Image.asset(
                                            'assets/images/debitcard.png'),
                                        Positioned(
                                          left: 50,
                                          bottom: 80,
                                          child: Container(
                                            child: Text(card.formattedNumber,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Positioned(
                                          left: 155,
                                          bottom: 45,
                                          child: Container(
                                            child: Text(
                                                "${card.expiryDate.month}/${card.expiryDate.year}",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                        Positioned(
                                          left: 50,
                                          bottom: 20,
                                          child: Container(
                                            child: Text(card.name,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.white)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "Balance".tr + "  ${account.balance}",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          _showWithdrawDialog(card.accountId);
                                        },
                                        child: Text("Withdraw".tr,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255,
                                                    68,
                                                    138,
                                                    255))), // White text
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showTransferDialog(
                                              card.accountId,
                                              context
                                                  .read<Accountprovider>()
                                                  .accounts);
                                        },
                                        child: Text("Transfer".tr,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255,
                                                    68,
                                                    138,
                                                    255))), // White text
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _showDepositDialog(card.accountId);
                                        },
                                        child: Text("Deposit".tr,
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255,
                                                    68,
                                                    138,
                                                    255))), // White text
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                    AnimatedNumber(
                      key: Key(
                          context.read<Accountprovider>().balance.toString()),
                      startValue: 0,
                      endValue: context.watch<Accountprovider>().balance,
                      duration: Duration(seconds: 3),
                      isFloatingPoint: false,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                    Container(
                      child: Text("Balance".tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  // Dialog to input transaction amounts with QR scan option
  void _showWithdrawDialog(int accountId) {
    amountController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Withrdaw Amount",
              style: TextStyle(color: const Color.fromARGB(255, 68, 138, 255))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount in KWD",
                  hintStyle:
                      TextStyle(color: const Color.fromARGB(255, 68, 138, 255)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () async {
                double amount = double.tryParse(amountController.text) ?? 0.0;

                await context
                    .read<Accountprovider>()
                    .withdraw(accountId, amount.toInt());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDepositDialog(int accountId) {
    amountController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Deposit Amount",
              style: TextStyle(color: const Color.fromARGB(255, 68, 138, 255))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount in KWD",
                  hintStyle:
                      TextStyle(color: const Color.fromARGB(255, 68, 138, 255)),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () async {
                double amount = double.tryParse(amountController.text) ?? 0.0;

                await context
                    .read<Accountprovider>()
                    .deposit(accountId, amount.toInt());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showTransferDialog(int accountId, List<Account> accounts) {
    setState(() {
      _selectedAccount = accounts.first;
      amountController.clear();
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Transfar Amount",
              style: TextStyle(color: const Color.fromARGB(255, 68, 138, 255))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter amount in KWD",
                  hintStyle:
                      TextStyle(color: const Color.fromARGB(255, 68, 138, 255)),
                ),
              ),
              DropdownButton<Account>(
                  items: accounts
                      .map(
                        (a) => DropdownMenuItem<Account>(
                          value: a,
                          child: Text(a.name),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    setState(() {
                      _selectedAccount = v;
                    });
                  }),
              ElevatedButton(
                onPressed: _scanQRCode,
                child: Text("Scan QR Code"),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm",
                  style: TextStyle(
                      color: const Color.fromARGB(255, 68, 138, 255))),
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;

                context
                    .read<Accountprovider>()
                    .withdraw(accountId, amount.toInt());

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
