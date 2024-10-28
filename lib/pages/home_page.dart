import 'package:burgan_app/models/transaction.dart';
import 'package:burgan_app/models/transactiontile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Import GoRouter package

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  double balance = 0.0; // Initial balance
  List<Transaction> transactions = []; // List to hold transaction history

  void _withdraw(double amount) {
    if (amount <= 0) {
      _showSnackBar("Please enter a valid amount");
      return;
    }
    if (balance >= amount) {
      setState(() {
        balance -= amount;
        transactions.insert(
          0,
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

  void _deposit(double amount) {
    if (amount <= 0) {
      _showSnackBar("Please enter a valid amount");
      return;
    }
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

  void _transfer(double amount, String iban, String recipientName) {
    if (amount <= 0) {
      _showSnackBar("Please enter a valid amount");
      return;
    }
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

  void _showSnackBar(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showTransactionDialog(String type) {
    TextEditingController amountController = TextEditingController();
    TextEditingController ibanController = TextEditingController();
    TextEditingController recipientNameController = TextEditingController();

    bool isTransfer = type == "Transfer";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("$type Amount"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(hintText: "Enter amount in KWD"),
              ),
              if (isTransfer) ...[
                const SizedBox(height: 10),
                TextField(
                  controller: ibanController,
                  decoration: const InputDecoration(hintText: "Enter IBAN"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: recipientNameController,
                  decoration:
                      const InputDecoration(hintText: "Recipient's name"),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Confirm"),
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
                Provider.of(context).pop();
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
        title: const Text("Burgan Wallet", style: TextStyle(fontSize: 22)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              context.go(
                  '/profile'); // Use GoRouter to navigate to the Profile page
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildBalanceSection(),
          const SizedBox(height: 10),
          _buildTransactionHistoryHeader(),
          const Divider(),
          _buildTransactionList(),
        ],
      ),
    );
  }

  Widget _buildBalanceSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "${balance.toStringAsFixed(2)} KWD",
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
          const Text("Balance",
              style: TextStyle(fontSize: 18, color: Colors.grey)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () => _showTransactionDialog("Withdraw"),
                child: const Text("Withdraw"),
              ),
              ElevatedButton(
                onPressed: () => _showTransactionDialog("Transfer"),
                child: const Text("Transfer"),
              ),
              ElevatedButton(
                onPressed: () => _showTransactionDialog("Deposit"),
                child: const Text("Deposit"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionHistoryHeader() {
    return const Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Text(
        "Transaction History",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTransactionList() {
    return Expanded(
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          TransactionTile(
            bankName: transaction.bankName,
            amount: transaction.amount,
            icon: transaction.icon,
            transactionType: transaction.transactionType,
          );
          return null;
        },
      ),
    );
  }
}
