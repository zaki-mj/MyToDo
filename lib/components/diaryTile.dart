import 'package:flutter/material.dart';

class Diary {
  String title;
  String body;

  Diary({required this.title, this.body = ""});
}

class DiaryTile extends StatelessWidget {
  final Diary diary;
  final Function() onDelete;
  final Function() onHold;

  DiaryTile({
    required this.diary,
    required this.onDelete,
    required this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onHold,
      child: Container(
        margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
        decoration: BoxDecoration(
            color: Colors.teal, borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(
            diary.title,
          ),
          leading: IconButton(
            icon: Icon(Icons.delete, color: Colors.grey[900]),
            onPressed: onDelete,
          ),
        ),
      ),
    );
  }
}
