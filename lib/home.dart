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
  Map<String, Map<String, dynamic>> expense = {
    'pen': {
      'price': 50,
      'date': DateTime(2020, 1, 1),
    },
    'pens': {'price': 50, 'date': DateTime(2020, 1, 1)}
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

  bool validateAddTransactionButton() {
    if (title.text.isNotEmpty && amount.text.isNotEmpty && _dateTime != null) {
      return true;
    } else {
      return false;
    }
  }

  bool validateClearAllDataButton() {
    if (title.text.isNotEmpty || amount.text.isNotEmpty || _dateTime != null) {
      return true;
    } else {
      return false;
    }
  }

  Widget? dropdown() {
    if (expense.length > 1) {
      return DropdownButtonHideUnderline(
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
      );
    } else {
      return Container();
    }
  }

  List<String> dropdownOptions = ['entry', 'name', 'price', 'date'];
  String dropdownValue = 'entry';
  bool _show = false;

  bool isTransactionAdded = false;
  String? _dateTime;
  bool isFloatingActionButtonVisible = true;
  TextEditingController title = TextEditingController();
  TextEditingController amount = TextEditingController();
  bool isValidateTitle = false;
  bool isValidateAmount = false;
  bool isDateSelected = true;
  bool isDuplicateKeyAvailable = false;

  Widget? _showBottomSheet() {
    try {
      if (_show) {
        return BottomSheet(
          onClosing: () {},
          builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                color: Colors.purple[100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: title,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        errorText: isValidateTitle ? 'Title is required' : null,
                      ),
                      keyboardType: TextInputType.text,
                      onChanged: (String value) {
                        setState(() {});
                      },
                    ),
                    Text(
                      isDuplicateKeyAvailable
                          ? 'Item name is already taken !'
                          : '',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: amount,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle:
                            const TextStyle(color: Colors.black, fontSize: 17),
                        errorText:
                            isValidateAmount ? 'Amount is required' : null,
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (String value) {
                        setState(() {});
                      },
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
                                lastDate: DateTime(2023),
                                builder: (context, child) => Theme(
                                      data: ThemeData().copyWith(
                                        colorScheme: const ColorScheme.dark(
                                          onPrimary: Colors.purple,
                                          surface: Colors.purple,
                                          onSurface: Colors.white,
                                        ),
                                        dialogBackgroundColor: Colors.purple,
                                      ),
                                      child: child!,
                                    )).then((date) {
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
                    Text(
                      isDateSelected == false ? 'Date is mandatory!' : '',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        validateClearAllDataButton()
                            ? ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.purple),
                                onPressed: () {
                                  title.clear();
                                  amount.clear();
                                  setState(() {
                                    _dateTime = null;
                                  });
                                },
                                icon: const Icon(Icons.clear),
                                label: const Text('Clear All Data'))
                            : Container(),
                        ElevatedButton.icon(
                          style: validateAddTransactionButton()
                              ? ElevatedButton.styleFrom(primary: Colors.purple)
                              : ElevatedButton.styleFrom(primary: Colors.grey),
                          onPressed: () {
                            if (validateAddTransactionButton() == true) {
                              setState(() {
                                title.text.isEmpty
                                    ? isValidateTitle = true
                                    : isValidateTitle = false;
                                amount.text.isEmpty
                                    ? isValidateAmount = true
                                    : isValidateAmount = false;
                                _dateTime == null
                                    ? isDateSelected = false
                                    : isDateSelected = true;
                                expense.containsKey(title.text)
                                    ? isDuplicateKeyAvailable = true
                                    : isDuplicateKeyAvailable = false;
                              });

                              if (isValidateAmount == false &&
                                  isValidateTitle == false &&
                                  isDateSelected == true &&
                                  isDuplicateKeyAvailable == false) {
                                expense[title.text] = {
                                  'price': int.parse(amount.text),
                                  'date': _dateTime,
                                };

                                title.clear();
                                amount.clear();
                                _dateTime = null;
                                setState(() {
                                  isTransactionAdded = !isTransactionAdded;
                                });
                                Future.delayed(const Duration(seconds: 1), () {
                                  setState(() {
                                    isTransactionAdded = !isTransactionAdded;
                                    _show = false;
                                    isFloatingActionButtonVisible = true;
                                  });
                                });
                              }
                            }
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
              dropdown()!,
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
