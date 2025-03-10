import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskTile extends StatelessWidget {
  final Task task;
  final Function(bool?) onChanged;
  final Function() onDelete;
  final Function() onHold;

  TaskTile({
    required this.task,
    required this.onChanged,
    required this.onDelete,
    required this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onHold,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(
            task.name,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: onChanged,
            checkColor: Color.fromARGB(255, 255, 255, 255),
            fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.selected)) {
                  return Color.fromARGB(255, 32, 53, 58); // Color when checked
                }
                return Colors.transparent; // Color when unchecked
              },
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.delete, color: Colors.grey[900]),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
