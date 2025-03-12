import 'package:flutter/material.dart';
import 'package:my_to_do/components/diaryTile.dart';
import 'package:my_to_do/pages/diaryEdit.dart';
import 'package:my_to_do/services/DiariesStorageManager.dart';
import 'package:my_to_do/global.dart';
// Ensure this is imported correctly

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => DiaryPageState();
}

class DiaryPageState extends State<DiaryPage> {
  // Make State class public
  Future<List<Diary>> _diariesFuture = StorageManager.loadDiaries();

  @override
  void initState() {
    super.initState();
    _loadDiaries();
  }

  void _loadDiaries() async {
    List<Diary> loadedDiaries = await StorageManager.loadDiaries();
    if (mounted) {
      setState(() {
        myDiaries = loadedDiaries;
        _diariesFuture =
            Future.value(myDiaries); // Ensure FutureBuilder updates
      });
    }
  }

  void refreshDiaries() {
    _loadDiaries(); // Allow external calls to refresh
  }

  void _deleteDiary(int index) async {
    setState(() {
      myDiaries.removeAt(index);
      _diariesFuture = Future.value(myDiaries);
    });
    await StorageManager.saveDiaries(myDiaries);
  }

  Future<void> _navigateToAddDiary(int? index) async {
    final diary = index != null ? myDiaries[index] : null;

    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDiaryPage(
          title: diary?.title ?? "",
          body: diary?.body ?? "",
          index: index, // Pass index for editing
        ),
      ),
    );

    if (result == true) {
      _loadDiaries(); // Reload list on return
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myDiaries.isEmpty
          ? const Center(child: Text("No diaries available"))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: myDiaries.length,
                itemBuilder: (context, index) {
                  return DiaryTile(
                    diary: myDiaries[index],
                    onTap: () => _navigateToAddDiary(index),
                    onHold: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                                'Are you sure you want to delete the diary diary?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _deleteDiary(index);
                                  Navigator.pop(context);
                                },
                                child: const Text('Yes',
                                    style: TextStyle(color: Colors.teal)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No',
                                    style: TextStyle(color: Colors.teal)),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
    );
  }
}
