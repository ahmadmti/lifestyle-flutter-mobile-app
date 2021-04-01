import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/Finance/widgetsIncome/new_transaction.dart';

import './chart_bar.dart';
import 'package:lifestyle/Finance/models/transaction.dart';

class Chart extends StatelessWidget {
  final List<mTransaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(4, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0, totalBudgetSum = 0.0;


      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].category == categories[index].toString()) {
          {
            totalSum += recentTransactions[i].amount;
                        totalBudgetSum = recentTransactions[i].totalBudget;

          }
        }
        // for (var i = 0; i < recentTransactions.length; i++) {
        //   if (recentTransactions[i].date.day == weekDay.day &&
        //       recentTransactions[i].date.month == weekDay.month &&
        //       recentTransactions[i].date.year == weekDay.year) {
        //     totalSum += recentTransactions[i].amount;
        //   }
      }
      return {
        'cat': categories[index].toString(),
        'amount': totalSum,
        'total_budget': totalBudgetSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['cat'],
                data['amount'],
                data['total_budget'],

                // totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                totalExpense: data['total_budget'],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
