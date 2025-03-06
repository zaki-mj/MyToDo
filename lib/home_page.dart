import 'package:flutter/material.dart';
import 'task_tile.dart';
import 'storage_manager.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  // Load tasks from local storage
  void _loadTasks() async {
    List<Task> tasks = await StorageManager.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  // Add a new task
  void _addTask(String taskName) {
    setState(() {
      _tasks.insert(
          0,
          Task(
              name: taskName,
              isCompleted: false)); // Add new task at the beginning
    });
    StorageManager.saveTasks(_tasks); // Save tasks to local storage
  }

  // Remove a task
  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    StorageManager.saveTasks(_tasks); // Save tasks to local storage
  }

  // Toggle task completion status
  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    StorageManager.saveTasks(_tasks); // Save tasks to local storage
  }

  // Show a dialog to add a new task
  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newTaskName = '';
        return AlertDialog(
          title: Text('Add a New Task'),
          content: TextField(
            cursorColor: Colors.teal,
            onChanged: (value) {
              newTaskName = value;
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .teal), // Set underline color to teal when focused
                ),
                hintText: 'Enter task name',
                focusColor: Colors.teal),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newTaskName.isNotEmpty) {
                  _addTask(newTaskName);
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Reverse the list of tasks to display newer tasks at the top
    List<Task> reversedTasks = List.from(_tasks.reversed);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('My To Do'),
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: reversedTasks.length,
        itemBuilder: (context, index) {
          return TaskTile(
            task: reversedTasks[index],
            onChanged: (value) {
              // Find the original index of the task in the _tasks list
              int originalIndex = _tasks.indexOf(reversedTasks[index]);
              _toggleTaskCompletion(originalIndex);
            },
            onDelete: () {
              // Find the original index of the task in the _tasks list
              int originalIndex = _tasks.indexOf(reversedTasks[index]);
              _removeTask(originalIndex);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
