import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'barChart.dart';
import 'expenseCard.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, Map<String, dynamic>> expense = {};

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
  bool _show = false;
  bool isDateChoosen = false;
  bool isTransactionAdded = false;
  String? _dateTime;
  bool isFloatingActionButtonVisible = true;
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();

  Widget? _showBottomSheet() {
    try {
      if (_show) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.5,
                child: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(5),
                  color: Colors.grey[400],
                  child: Column(
                    children: [
                      TextField(
                        controller: title,
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: amount,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_dateTime == null
                              ? 'No date Choosen!'
                              : _dateTime.toString()),
                          TextButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2023))
                                  .then((date) {
                                setState(() {
                                  _dateTime =
                                      DateFormat('yyyy-MM-dd').format(date!);
                                });
                              });
                            },
                            child: const Text(
                              'Choose Date',
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.purple),
                            onPressed: () {
                              setState(() {
                                isTransactionAdded = !isTransactionAdded;

                                expense[title.text] = {
                                  'price': int.parse(amount.text),
                                  'date': _dateTime,
                                };
                                title.clear();
                                amount.clear();
                                _dateTime = null;
                              });
                            },
                            icon: Icon(isTransactionAdded == true
                                ? Icons.check
                                : Icons.add),
                            label: Text(isTransactionAdded == true
                                ? 'Added Successfully'
                                : 'Add Transaction'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      } else {
        return null;
      }
    } catch (e) {
      print('Exception occurs:$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GestureDetector(
        child: Scaffold(
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
                        style: const TextStyle(color: Colors.white),
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
              IconButton(
                onPressed: () {
                  setState(() {
                    _show = true;
                    isFloatingActionButtonVisible = false;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          floatingActionButton: Visibility(
            visible: isFloatingActionButtonVisible,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _show = true;
                  isFloatingActionButtonVisible = false;
                });
              },
              backgroundColor: Colors.purple,
              child: const Icon(Icons.add),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: GestureDetector(
            onTap: () {
              setState(() {
                isFloatingActionButtonVisible = true;
                _show = false;

                isDateChoosen = false;
              });
            },
            child: Column(
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
          bottomSheet: _showBottomSheet(),
        ),
      ),
    );
  }
}
