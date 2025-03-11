import 'package:my_to_do/components/diaryTile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static const String _diariesKey = 'diaries';

  // Save diaries to local storage
  static Future<void> saveDiaries(List<Diary> diaries) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> diaryStrings = diaries.map((diary) {
      return '${diary.title}|${diary.body}';
    }).toList();
    await prefs.setStringList(_diariesKey, diaryStrings);
  }

  // Load diaries from local storage
  static Future<List<Diary>> loadDiaries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? diaryStrings = prefs.getStringList(_diariesKey);
    if (diaryStrings == null) return [];
    return diaryStrings.map((diaryString) {
      List<String> parts = diaryString.split('|');
      return Diary(title: parts[0], body: parts[1]);
    }).toList();
  }
}
