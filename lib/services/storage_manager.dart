import 'package:shared_preferences/shared_preferences.dart';
import '../components/task_tile.dart';

class StorageManager {
  // Key for storing tasks in SharedPreferences
  static const String _tasksKey = 'tasks';

  // Save tasks to local storage
  static Future<void> saveTasks(List<Task> tasks) async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert tasks to a list of strings (e.g., "taskName|isCompleted")
    List<String> taskStrings = tasks.map((task) {
      return '${task.name}|${task.isCompleted}';
    }).toList();

    // Save the list of strings to SharedPreferences
    await prefs.setStringList(_tasksKey, taskStrings);
  }

  // Load tasks from local storage
  static Future<List<Task>> loadTasks() async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of task strings from SharedPreferences
    List<String>? taskStrings = prefs.getStringList(_tasksKey);

    // If no tasks are saved, return an empty list
    if (taskStrings == null) {
      return [];
    }

    // Convert the list of strings back to a list of Task objects
    List<Task> tasks = taskStrings.map((taskString) {
      List<String> parts = taskString.split('|');
      String name = parts[0];
      bool isCompleted = parts[1] == 'true';
      return Task(name: name, isCompleted: isCompleted);
    }).toList();

    return tasks;
  }
}