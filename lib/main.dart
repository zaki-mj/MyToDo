import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_to_do/pages/welcome.dart';
import 'package:my_to_do/pages/home_page.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);

  final prefs = await SharedPreferences.getInstance();
  final String? storedName = prefs.getString('user_name');

  runApp(TodoListApp(
      initialPage: storedName == null ? WelcomePage() : HomePage()));
}

class TodoListApp extends StatelessWidget {
  final Widget initialPage;

  const TodoListApp({super.key, required this.initialPage});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mee',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
      home: initialPage,
    );
  }
}
