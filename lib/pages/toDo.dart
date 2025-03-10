import 'package:flutter/material.dart';
import 'package:my_to_do/services/TasksStorageManager.dart';
import 'package:my_to_do/components/task_tile.dart';

class ToDo extends StatefulWidget {
  const ToDo({Key? key}) : super(key: key);

  @override
  ToDoState createState() => ToDoState();
}

class ToDoState extends State<ToDo> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    List<Task> tasks = await StorageManager.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask(String taskName) {
    setState(() {
      _tasks.insert(0, Task(name: taskName, isCompleted: false));
    });
    StorageManager.saveTasks(_tasks);
  }

  void _editTask(int index, String newName) {
    setState(() {
      _tasks[index].name = newName;
    });
    StorageManager.saveTasks(_tasks);
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    StorageManager.saveTasks(_tasks);
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    StorageManager.saveTasks(_tasks);
  }

  void showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newTaskName = '';
        return AlertDialog(
          title: const Text('Add a New Task'),
          content: TextField(
            cursorColor: Colors.teal,
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
              ),
              hintText: 'Enter task name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newTaskName.isNotEmpty) {
                  _addTask(newTaskName);
                  Navigator.pop(context);
                }
              },
              child: const Text('Add', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _tasks.length,
      itemBuilder: (context, index) {
        return TaskTile(
          task: _tasks[index],
          onChanged: (value) => _toggleTaskCompletion(index),
          onDelete: () => _removeTask(index),
          onHold: () => _editTask(index, _tasks[index].name),
        );
      },
    );
  }
}
