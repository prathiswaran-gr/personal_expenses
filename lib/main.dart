import 'package:flutter/material.dart';
import './data.dart';
import './cardList.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var dataList = [
    Data(item: 'Shoes', price: 599, date: 'Jan 31,2021'),
    Data(item: 'Mobile', price: 10000, date: 'Feb 10,2021'),
    Data(item: 'Shirts', price: 400, date: 'Feb 12,2020'),
    Data(item: 'Laptop', price: 49999, date: 'Jan 05,2020'),
    
  ];
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Expenses'),
          backgroundColor: Colors.purple,
          centerTitle: false,
          actions: [
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.add),
              label: Text(''),
              style: TextButton.styleFrom(primary: Colors.white),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.amber,
          child: Icon(Icons.add, color: Colors.black),
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
