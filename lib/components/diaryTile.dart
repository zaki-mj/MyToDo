import 'package:flutter/material.dart';
import 'package:my_to_do/components/misc.dart';

class Diary {
  String title;
  String body;

  Diary({required this.title, this.body = ""});
}

class DiaryTile extends StatelessWidget {
  final Diary diary;
  final Function() onTap;
  final Function() onHold;

  DiaryTile({
    required this.diary,
    required this.onTap,
    required this.onHold,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onHold,
      child: Container(
          margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
          decoration: BoxDecoration(
              color: Colors.teal, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(9.5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  diary.title,
                  maxLines: 2,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(screenHeight * .005),
                Text(
                  diary.body,
                  maxLines: 3,
                )
              ],
            ),
          )),
    );
  }
}
