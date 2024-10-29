import 'package:burgan_app/models/transaction.dart';
import 'package:burgan_app/models/transactiontile.dart';
import 'package:flutter/material.dart';

import 'profile_page.dart';
import 'dart:io';

class MainPage extends StatefulWidget {
  // final String name;
  // final String username;
  // final String phoneNumber;
  // final String address;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double balance = 0.0; // Initial balance
  List<Transaction> transactions = []; // List to hold transaction history
  File? _profileImage; // Profile picture state

  // Method to get greeting based on the time of day
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning,";
    } else if (hour < 17) {
      return "Good Afternoon,";
    } else {
      return "Good Evening,";
    }
  }

  // Method to open profile page and handle updated profile picture
  // Future<void> _navigateToProfilePage() async {
  //   final result = await Navigator.push(
  //     context,
  // MaterialPageRoute(
  // builder: (context) => ProfilePage(
  //   name: widget.name,
  //   username: widget.username,
  //   phoneNumber: widget.phoneNumber,
  //   address: widget.address,
  //   profilePicture: _profileImage, // Pass the current profile image
  // ),
  // ),
  // );

  //   if (result != null && result is File) {
  //     setState(() {
  //       _profileImage = result; // Update the profile image after changes
  //     });
  //   }
  // }

  // Method to handle Withdraw
  void _withdraw(double amount) {
    if (balance >= amount) {
      setState(() {
        balance -= amount;
        transactions.insert(
          0, // Insert at the beginning of the list
          Transaction(
              bankName: "You",
              amount: "-${amount.toStringAsFixed(2)} KWD",
              icon: Icons.money_off,
              transactionType: "Withdraw"),
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
        0, // Insert at the beginning of the list
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
        balance -= amount; // Subtracting from your wallet
        transactions.insert(
          0, // Insert at the beginning of the list
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

  // Dialog to input transaction amounts
  void _showTransactionDialog(String type) {
    TextEditingController amountController = TextEditingController();
    TextEditingController ibanController = TextEditingController();
    TextEditingController recipientNameController = TextEditingController();

    bool isTransfer = type == "Transfer";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$type Amount",
              style: TextStyle(
                  color:
                      const Color.fromARGB(255, 68, 138, 255))), // White title
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter amount in KWD",
                    hintStyle: TextStyle(
                        color: const Color.fromARGB(
                            255, 68, 138, 255))), // White hint text
              ),
              if (isTransfer) ...[
                SizedBox(height: 10),
                TextField(
                  controller: ibanController,
                  decoration: InputDecoration(
                      hintText: "Enter IBAN",
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(
                              255, 68, 138, 255))), // White hint text
                ),
                SizedBox(height: 10),
                TextField(
                  controller: recipientNameController,
                  decoration: InputDecoration(
                      hintText: "Recipient's name",
                      hintStyle: TextStyle(
                          color: const Color.fromARGB(
                              255, 0, 118, 202))), // White hint text
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel",
                  style: TextStyle(
                      color: const Color.fromARGB(
                          255, 68, 138, 255))), // White text
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm",
                  style: TextStyle(
                      color: const Color.fromARGB(
                          255, 68, 138, 255))), // White text
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                String iban = ibanController.text;
                String recipientName = recipientNameController.text;

                if (amount > 0) {
                  if (type == "Withdraw") {
                    _withdraw(amount);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Burgan Wallet",
            style: TextStyle(
                fontSize: 22,
                color: const Color.fromARGB(255, 68, 138, 255))), // White title
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // User Greeting Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    // onTap: _navigateToProfilePage, // Profile icon is clickable
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: _profileImage != null
                          ? NetworkImage(_profileImage!.path)
                          : AssetImage('assets/Images/default_profile.png')
                              as ImageProvider,
                    ),
                  ),
                  SizedBox(width: 10), // Space between icon and text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: TextStyle(
                            fontSize: 18, color: Colors.white), // White text
                      ),
                      // Text(
                      //   widget.name,
                      //   style: TextStyle(
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Colors.white), // White text
                      //   overflow: TextOverflow.ellipsis, // To handle long names
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            // Balance and Portfolio section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "${balance.toStringAsFixed(2)} KWD",
                    style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // White text
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10, bottom: 40),
                    child: Text("Balance",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ), // White text
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _showTransactionDialog("Withdraw");
                        },
                        child: Text("Withdraw",
                            style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 68, 138, 255))), // White text
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showTransactionDialog("Transfer");
                        },
                        child: Text("Transfer",
                            style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 68, 138, 255))), // White text
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showTransactionDialog("Deposit");
                        },
                        child: Text("Deposit",
                            style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 68, 138, 255))), // White text
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft, // Align the text to the left
                child: Container(
                  padding: EdgeInsets.only(bottom: 30, top: 30),
                  child: Text(
                    "Transaction History",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white), // White text
                  ),
                ),
              ),
            ),
            SizedBox(height: 10), // Space between text and divider
            Divider(color: Colors.white), // White divider
            // Expanded to make the transaction history take the rest of the space
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionTile(
                    bankName: transaction.bankName,
                    amount: transaction.amount,
                    icon: transaction.icon,
                    transactionType: transaction
                        .transactionType, // Pass transaction type here
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
