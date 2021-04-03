import 'package:flutter/material.dart';

class mTransaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final double totalBudget;

  mTransaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
     this.category,
    this.totalBudget,
  });
}
