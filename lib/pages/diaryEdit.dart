import 'package:flutter/material.dart';
import 'package:my_to_do/components/diaryTile.dart';
import 'package:my_to_do/services/DiariesStorageManager.dart';
import 'diary.dart';
import 'package:my_to_do/global.dart';

class EditDiaryPage extends StatefulWidget {
  const EditDiaryPage({super.key});

  @override
  State<EditDiaryPage> createState() => _EditDiaryPageState();
}

class _EditDiaryPageState extends State<EditDiaryPage> {
  void initState() {
    super.initState();
    _loadDiaries();
  }

  void _loadDiaries() async {
    List<Diary> diaries = await StorageManager.loadDiaries();
    setState(() {
      myDiaries = diaries;
    });
  }

  void _addDiary(String diaryName, String diaryBody) {
    setState(() {
      myDiaries.insert(0, Diary(title: diaryName, body: diaryBody));
    });
  }

  final TextEditingController titleController = TextEditingController();
  final TextEditingController diaryController = TextEditingController();
  final FocusNode titleFocus = FocusNode();
  final FocusNode bodyFocus = FocusNode();

  @override
  void dispose() {
    titleController.dispose();
    diaryController.dispose();
    titleFocus.dispose();
    bodyFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Diary Editor'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // Title Input
            TextField(
              controller: titleController,
              focusNode: titleFocus,
              cursorColor: Colors.teal,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(bodyFocus),
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                hintText: 'Enter diary title',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 15),

            // Diary Text Input
            Expanded(
              child: TextField(
                controller: diaryController,
                focusNode: bodyFocus,
                cursorColor: Colors.teal,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.teal.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Write your diary here...',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  contentPadding: EdgeInsets.all(15),
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),

      // Floating Save Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final title = titleController.text;
          final body = diaryController.text;
          if (title.isNotEmpty) {
            _addDiary(title, body);
            print(myDiaries.length.toString());
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Please enter a title and content')),
            );
          }
          ;
          Navigator.pop(context);
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
