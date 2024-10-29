import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String bankName;
  final String amount;
  final IconData icon;
  final String transactionType;

  const TransactionTile({
    required this.bankName,
    required this.amount,
    required this.icon,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        bankName,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "Transaction", // or any additional info
        style: TextStyle(color: Colors.white70),
      ),
      trailing: Text(
        amount,
        style: TextStyle(
          fontSize: 16, // Set your preferred size
          fontWeight: FontWeight.bold,
          color: transactionType == "Deposit" ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
