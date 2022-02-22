import 'package:flutter/material.dart';

import 'barChart.dart';
import 'expenseCard.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, Map<String, dynamic>> expense = {
    'Mobile': {'price': 9999, 'date': DateTime(2021, 2, 14)},
    'Note Books': {'price': 99, 'date': DateTime(2021, 2, 15)},
    'Stationary ': {'price': 250, 'date': DateTime(2022, 1, 31)},
    'Bag': {'price': 499, 'date': DateTime(2022, 2, 18)},
    'Post covers': {'price': 10, 'date': DateTime(2022, 1, 04)},
    'A4 Sheets': {'price': 249, 'date': DateTime(2022, 1, 23)},
    'Watch': {'price': 99, 'date': DateTime(2022, 1, 11)},
    'Shirts': {'price': 412, 'date': DateTime(2022, 1, 21)},
    'Sun Glass': {'price': 80, 'date': DateTime(2022, 1, 1)}
  };

  List<String> getSortedList() {
    if (dropdownValue == 'entry') {
      return expense.keys.toList();
    } else if (dropdownValue == 'name') {
      return (expense.keys.toList()..sort());
    } else {
      return expense.keys.toList()
        ..sort(
          (k1, k2) => (expense[k1]![dropdownValue])
              .compareTo((expense[k2]![dropdownValue])),
        );
    }
  }

  List<String> dropdownOptions = ['entry', 'name', 'price', 'date'];
  String dropdownValue = 'entry';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          backgroundColor: Colors.purple,
          elevation: 0.0,
          actions: [
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: dropdownValue,
                items: dropdownOptions.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                icon: const Icon(Icons.filter_list_sharp),
                onChanged: (String? value) {
                  setState(() {
                    dropdownValue = value!;
                  });
                },
                iconEnabledColor: Colors.white,
                dropdownColor: Colors.purple,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            const BarChart(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: getSortedList()
                      .map(
                        (key) => ExpenseCard(
                          item: key,
                          price: expense[key]!['price'],
                          date: expense[key]!['date'],
                          deleteFunction: () {
                            setState(() {
                              expense.remove(key);
                            });
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
