import 'package:flutter/material.dart';
import 'package:my_to_do/components/drawer.dart';
import 'package:my_to_do/pages/diary.dart';
import 'package:my_to_do/pages/diaryEdit.dart';
import 'package:my_to_do/pages/toDo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ToDoState> _toDoKey = GlobalKey<ToDoState>();
  final GlobalKey<DiaryPageState> _diaryKey =
      GlobalKey<DiaryPageState>(); // Add this

  List<Widget> get navigationBarBody => [
        ToDo(key: _toDoKey),
        DiaryPage(key: _diaryKey), // Use the key
      ];

  void _showAddTaskDialog() {
    _toDoKey.currentState?.showAddTaskDialog();
  }

  void additionController(int index) async {
    if (index == 0) {
      _showAddTaskDialog();
    } else {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditDiaryPage()),
      );

      if (result == true) {
        _diaryKey.currentState?.refreshDiaries(); // Refresh DiaryPage
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Mee'),
        centerTitle: true,
      ),
      drawer: MyDrawer(), // Pass the callback
      body: navigationBarBody[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.teal,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "Tasks"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_rounded), label: "Diary")
        ],
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          additionController(_currentIndex);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
