import 'package:flutter/material.dart';

import 'barChart.dart';
import 'expenseCard.dart';

class SortByEntry extends StatefulWidget {
  final dynamic expense;
  const SortByEntry({this.expense});

  @override
  State<SortByEntry> createState() => _SortByEntryState();
}

class _SortByEntryState extends State<SortByEntry> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BarChart(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: widget.expense.keys
                  .map(
                    (key) => ExpenseCard(
                      item: key,
                      price: widget.expense[key]!['price'],
                      date: widget.expense[key]!['date'],
                      deleteFunction: () {
                        setState(() {
                          widget.expense.remove(key);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
