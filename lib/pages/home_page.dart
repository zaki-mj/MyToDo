import 'package:flutter/material.dart';
import 'package:my_to_do/components/drawer.dart';
import 'package:my_to_do/pages/toDo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final GlobalKey<ToDoState> _toDoKey = GlobalKey<ToDoState>();

  List<Widget> get navigationBarBody => [
        ToDo(key: _toDoKey),
        const Icon(Icons.sticky_note_2),
      ];

  void _showAddTaskDialog() {
    _toDoKey.currentState?.showAddTaskDialog();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('My To Do'),
        centerTitle: true,
      ),
      drawer: myDrawer(),
      body: navigationBarBody[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.check_box), label: "ToDo"),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2_rounded), label: "Notes")
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
        onPressed: _showAddTaskDialog,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
