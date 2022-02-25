import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final dynamic item;
  final dynamic price;
  final dynamic date;
  final dynamic deleteFunction;

  ExpenseCard({this.item, this.price, this.date, this.deleteFunction});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.purple,
            child: Text(
              '₹' + price.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            radius: 30,
          ),
          title: Text(
            item,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          subtitle: Text(
            date.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text(
                    'Are you sure?',
                    style: TextStyle(color: Colors.white),
                  ),
                  content: const Text(
                    'Do you want to delete?',
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[300],
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple[300],
                      ),
                      onPressed: () {
                        deleteFunction();
                        Navigator.pop(context);
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                  elevation: 24.0,
                  backgroundColor: Colors.purple,
                ),
              );
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
