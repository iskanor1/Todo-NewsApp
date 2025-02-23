
import 'package:flutter/material.dart';

class DoneTasksscreen extends StatelessWidget {
  const DoneTasksscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Done Tasks',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}