import 'package:flutter/material.dart';
import 'package:my_to_do/components/diaryTile.dart';
import 'package:my_to_do/services/DiariesStorageManager.dart';
import 'package:my_to_do/global.dart';

class EditDiaryPage extends StatefulWidget {
  final String title;
  final String body;
  final int? index; // Null if creating a new diary

  const EditDiaryPage({super.key, this.title = "", this.body = "", this.index});

  @override
  State<EditDiaryPage> createState() => _EditDiaryPageState();
}

class _EditDiaryPageState extends State<EditDiaryPage> {
  late TextEditingController titleController;
  late TextEditingController diaryController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    diaryController = TextEditingController(text: widget.body);
  }

  @override
  void dispose() {
    titleController.dispose();
    diaryController.dispose();
    super.dispose();
  }

  void _saveDiary() async {
    final title = titleController.text.trim();
    final body = diaryController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and content')),
      );
      return;
    }

    if (widget.index != null) {
      // Editing an existing diary
      myDiaries[widget.index!] = Diary(title: title, body: body);
    } else {
      // Adding a new diary
      myDiaries.insert(0, Diary(title: title, body: body));
    }

    await StorageManager.saveDiaries(myDiaries); // Save updated list

    if (mounted) {
      Navigator.pop(context, true); // Return true to indicate success
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.index == null ? 'New Diary' : 'Edit Diary'),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              cursorColor: Colors.teal,
              textInputAction: TextInputAction.next,
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
