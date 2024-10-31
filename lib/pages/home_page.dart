import 'package:animated_number/animated_number.dart';
import 'package:burgan_app/models/account.dart';
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

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double balance = 0.0; // Initial balance
  List<Transaction> transactions = []; // List to hold transaction history
  File? _profileImage; // Profile picture state
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR'); // QR Key for QR scanner
  QRViewController? qrController; // QR Controller for handling scanner
  TextEditingController amountController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController recipientNameController = TextEditingController();

  Account? _selectedAccount;

  // Method to get greeting based on the time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "${'goodMorning'.tr},";
    } else if (hour < 17) {
      return "${'goodAfternoon'.tr},";
    } else {
      return "${'GoodEvening'.tr},";
    }
  }

  // Method to handle Withdraw
  void _withdraw(double amount) {
    if (balance >= amount) {
      setState(() {
        balance -= amount;
        transactions.insert(
          0,
          Transaction(
              bankName: "${'you'.tr}",
              amount: "-${amount.toStringAsFixed(2).tr} ${'KWD'}",
              icon: Icons.money_off,
              transactionType: "${"Withdraw".tr}"),
        );
      });
    } else {
      _showSnackBar("Insufficient balance for withdrawal");
    }
  }

// Method to handle Deposit
  void _deposit(double amount) {
    setState(() {
      balance += amount;
      transactions.insert(
        0,
        Transaction(
            bankName: "You",
            amount: "+${amount.toStringAsFixed(2)} KWD",
            icon: Icons.attach_money,
            transactionType: "Deposit"),
      );
    });
  }

// Method to handle Transfer
  void _transfer(double amount, String iban, String recipientName) {
    if (balance >= amount) {
      setState(() {
        balance -= amount;
        transactions.insert(
          0,
          Transaction(
              bankName: "Transfer to $recipientName\nIBAN: $iban",
              amount: "-${amount.toStringAsFixed(2)} KWD",
              icon: Icons.transfer_within_a_station,
              transactionType: "Transfer"),
        );
      });
    } else {
      _showSnackBar("Insufficient balance for transfer");
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

// Dialog to input transaction amounts with QR scan option
  void _showTransactionDialog(String type) {
    bool isTransfer = type == "Transfer";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$type Amount",
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
              if (isTransfer) ...[
                SizedBox(height: 10),
                TextField(
                  controller: ibanController,
                  decoration: InputDecoration(
                    hintText: "Enter IBAN",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 68, 138, 255)),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: recipientNameController,
                  decoration: InputDecoration(
                    hintText: "Recipient's name",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(255, 0, 118, 202)),
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _scanQRCode,
                  child: Text("Scan QR Code"),
                ),
              ],
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
                String iban = ibanController.text;
                String recipientName = recipientNameController.text;

                if (amount > 0) {
                  if (type == "Withdraw") {
                    // context.read<Accountprovider>()
                  } else if (type == "Deposit") {
                    _deposit(amount);
                  } else if (type == "Transfer") {
                    if (iban.isNotEmpty && recipientName.isNotEmpty) {
                      _transfer(amount, iban, recipientName);
                    } else {
                      _showSnackBar(
                          "Please fill in all fields for the transfer.");
                    }
                  }
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    qrController?.dispose();
    super.dispose();
  }

  //
  @override
  Widget build(BuildContext _c) {
    return Scaffold(
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
      body: FutureBuilder(
          future: Future.wait([
            _c.read<Accountprovider>().get(),
            _c.read<BankCardProvider>().get(),
          ]),
          builder: (_p, sp) {
            if (sp.connectionState == ConnectionState.waiting) {
              // DO BETTER LOADING
              return CircularProgressIndicator();
            }

            return Consumer<BankCardProvider>(
                builder: (context, cardProvider, _) {
              var cards = context.watch<BankCardProvider>().cards;

              return RefreshIndicator(
                onRefresh: () => Future.wait(
                  [
                    _c.read<Accountprovider>().get(),
                    _c.read<BankCardProvider>().get(),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      // ElevatedButton(
                      //     onPressed: () {
                      //       context.read<BankCardProvider>().get();
                      //       print(context.read<AuthProvider>().user?.token);
                      //     },
                      //     child: Text("Load")),
                      // User Greeting Section
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
                                  _getGreeting(),
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
                                            _showTransactionDialog("Transfer");
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
                        key: UniqueKey(),
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
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: Container(
                      //       padding: EdgeInsets.only(bottom: 30, top: 30),
                      //       child: Text(
                      //         'Transaction History'.tr,
                      //         style: TextStyle(
                      //             fontSize: 20,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.all(5),
                      //   child: Text(
                      //     'Coming Soon'.tr,
                      //     style: TextStyle(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.white),
                      //   ),
                      // ),
                      // SizedBox(height: 10),
                      // Divider(color: Colors.white),
                      // Expanded(
                      //   child: ListView.builder(
                      //     itemCount: transactions.length,
                      //     itemBuilder: (context, index) {
                      //       final transaction = transactions[index];
                      //       return TransactionTile(
                      //         bankName: transaction.bankName,
                      //         amount: transaction.amount,
                      //         icon: transaction.icon,
                      //         transactionType: transaction.transactionType,
                      //       );
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            });
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
          title: Text("deposit Amount",
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

  // Dialog to input transaction amounts with QR scan option
  void _showTransferDialog(int accountId, List<Account> accounts) {
    setState(() {
      _selectedAccount = accounts.first;
    });
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
                  })
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
                String iban = ibanController.text;
                String recipientName = recipientNameController.text;

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
