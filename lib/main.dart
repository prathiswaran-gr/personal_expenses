import 'package:flutter/material.dart';
import './data.dart';
import './cardList.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dataList = [
    Data(item: 'Shoes', price: 599, date: 'Jan 31,2021'),
    Data(item: 'Mobile', price: 9999, date: 'Feb 01,2021'),
    Data(item: 'Shirts', price: 400, date: 'Feb 02,2020'),
    Data(item: 'Books', price: 199, date: 'Feb 03,2020'),
    Data(item: 'A4 sheets bundle', price: 299, date: 'Feb 04,2020'),
    Data(item: 'Post covers', price: 100, date: 'Feb 05,2020'),
    Data(item: 'Prepaid Recharge', price: 719, date: 'Jan 05,2020'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Expenses'),
          backgroundColor: Colors.purple,
          centerTitle: false,
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text(''),
              style: TextButton.styleFrom(primary: Colors.white),
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
        body: SingleChildScrollView(
          child: Column(
            children: dataList
                .map(
                  (data) => CardList(
                      data: data,
                      deleteFunction: () {
                        setState(() {
                          dataList.remove(data);
                        });
                      }),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
