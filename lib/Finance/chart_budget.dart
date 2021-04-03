import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifestyle/Finance/setBudget.dart';
import 'package:lifestyle/Finance/widgetsExpense/chart_bar.dart';
import 'package:lifestyle/Finance/widgetsIncome/new_transaction.dart';

import 'package:lifestyle/Finance/models/transaction.dart';

class ChartBudget extends StatelessWidget {
  final List<mTransaction> recentTransactions;

  ChartBudget(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(4, (index) {
      // final weekDay = DateTime.now().subtract(
      //   Duration(days: index),
      // );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].category == categories[index].toString()) {
          totalSum += recentTransactions[i].amount;

                print("${recentTransactions[i].category}=> ${recentTransactions[i].amount}");

        }
      }

      
      return {
        // 'day': DateFormat.E().format(weekDay).substring(0, 1),
        'cat': categories[index].toString(),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum+ item['amount'];
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
            // print("cat: ${data['cat']}");
            // print("amount: ${data['amount']}");
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['cat'],
                data['amount'],
                // totalSpending == 0.0 ? 0.0 : (data['amount'] as double) / totalSpending,
                data['amount'] == 0.0 ? 0.0 : 1.0,
                
                
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
