import 'package:flutter/material.dart';
import 'package:my_to_do/components/diaryTile.dart';
import 'package:my_to_do/services/DiariesStorageManager.dart';
import 'package:my_to_do/global.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  Future<List<Diary>>? _diariesFuture;

  @override
  void initState() {
    super.initState();
    _diariesFuture = _loadDiaries();
  }

  Future<List<Diary>> _loadDiaries() async {
    List<Diary> diaries = await StorageManager.loadDiaries();
    setState(() {
      myDiaries = diaries; // Update global list
    });
    return myDiaries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("My Diaries"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Diary>>(
        future: _diariesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Error loading diaries"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No diaries available"));
          }

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return DiaryTile(
                  diary: snapshot.data![index],
                  onDelete: () {
                    _deleteDiary(index);
                  },
                  onHold: () {}, // Add logic if needed
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _deleteDiary(int index) async {
    setState(() {
      myDiaries.removeAt(index);
      _diariesFuture = Future.value(myDiaries); // Update future
    });
    await StorageManager.saveTasks(myDiaries);
  }
}
