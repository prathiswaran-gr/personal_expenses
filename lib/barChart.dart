import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(50),
        child: ListTile(
          title: Text(
            'Bar Chart',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
