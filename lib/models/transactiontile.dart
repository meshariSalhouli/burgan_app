import 'package:flutter/material.dart';

class TransactionTile extends StatelessWidget {
  final String bankName;
  final String amount;
  final IconData icon;
  final String transactionType;

  const TransactionTile({
    super.key,
    required this.bankName,
    required this.amount,
    required this.icon,
    required this.transactionType,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(
        "$transactionType - $bankName",
        style: const TextStyle(fontSize: 18),
      ),
      trailing: Text(amount, style: const TextStyle(fontSize: 18)),
    );
  }
}
