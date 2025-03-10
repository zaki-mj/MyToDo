import 'package:my_to_do/components/diaryTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  // Key for storing tasks in SharedPreferences
  static const String _diariesKey = 'diaries';

  // Save tasks to local storage
  static Future<void> saveTasks(List<Diary> diaries) async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert tasks to a list of strings (e.g., "taskName|isCompleted")
    List<String> diaryStrings = diaries.map((diary) {
      return '${diary.title}|${diary.body}';
    }).toList();

    // Save the list of strings to SharedPreferences
    await prefs.setStringList(_diariesKey, diaryStrings);
  }

  // Load tasks from local storage
  static Future<List<Diary>> loadDiaries() async {
    // Get an instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve the list of task strings from SharedPreferences
    List<String>? diaryStrings = prefs.getStringList(_diariesKey);

    // If no tasks are saved, return an empty list
    if (diaryStrings == null) {
      return [];
    }

    // Convert the list of strings back to a list of Task objects
    List<Diary> diaries = diaryStrings.map((diaryString) {
      List<String> parts = diaryString.split('|');
      String _title = parts[0];
      String _body = parts[1];
      return Diary(title: _title,body: _body);
    }).toList();

    return diaries;
  }
}