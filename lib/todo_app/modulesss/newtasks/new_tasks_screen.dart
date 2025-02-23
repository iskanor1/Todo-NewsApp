import 'package:flutter/material.dart';

import '../../../componets/componets.dart';
import '../../shareded/componets/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index], context), // Pass both arguments
      separatorBuilder: (context, index) => Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
      itemCount: tasks.length,
    );
  }
}