import 'package:flutter/material.dart';

import 'chartBar.dart';

class BarChart extends StatelessWidget {
  final Iterable<Map<String, dynamic>> recentTransactions;
  BarChart(this.recentTransactions);

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
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
          children: recentTransactions.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: Chart(
                label: data['date'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
            // return Text('text') as Widget;
          }).toList(),
        ),
      ),
    );
  }
}
