import 'package:flutter/material.dart';
import 'package:my_to_do/components/diaryTile.dart';
import 'package:my_to_do/services/DiariesStorageManager.dart';
import 'package:my_to_do/global.dart';

class EditDiaryPage extends StatefulWidget {
  const EditDiaryPage({super.key});

  @override
  State<EditDiaryPage> createState() => _EditDiaryPageState();
}

class _EditDiaryPageState extends State<EditDiaryPage> {
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

  void _saveDiary() async {
    final title = titleController.text.trim();
    final body = diaryController.text.trim();

    if (title.isNotEmpty && body.isNotEmpty) {
      setState(() {
        myDiaries.insert(0, Diary(title: title, body: body));
      });

      await StorageManager.saveDiaries(myDiaries); // Save updated list

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and content')),
      );
    }
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
            TextField(
              controller: titleController,
              focusNode: titleFocus,
              cursorColor: Colors.teal,
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => FocusScope.of(context).requestFocus(bodyFocus),
              decoration: const InputDecoration(
                hintText: 'Enter diary title',
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 15),
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
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  hintText: 'Write your diary here...',
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _saveDiary,
        backgroundColor: Colors.teal,
        child: const Icon(Icons.save, color: Colors.white),
      ),
    );
  }
}
