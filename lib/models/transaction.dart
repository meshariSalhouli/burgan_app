import 'package:flutter/material.dart';

class Transaction {
  final String bankName;
  final String amount;
  final IconData icon;
  final String transactionType;

  Transaction({
    required this.bankName,
    required this.amount,
    required this.icon,
    required this.transactionType,
  });
}
