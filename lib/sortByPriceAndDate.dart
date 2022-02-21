import 'package:flutter/material.dart';

import 'barChart.dart';
import 'expenseCard.dart';

class SortByPriceAndDate extends StatefulWidget {
  final dynamic expense;
  final String? dropdownValue;
  const SortByPriceAndDate({this.expense, this.dropdownValue});

  @override
  _SortByPriceAndDateState createState() => _SortByPriceAndDateState();
}

class _SortByPriceAndDateState extends State<SortByPriceAndDate> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const BarChart(),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: (widget.expense.keys.toList()
                    ..sort(
                      (k1, k2) => (widget.expense[k1]![widget.dropdownValue])
                          .compareTo(
                              (widget.expense[k2]![widget.dropdownValue])),
                    ))
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
