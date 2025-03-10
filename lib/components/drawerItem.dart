import 'package:flutter/material.dart';
import 'package:my_to_do/components/misc.dart';

class Draweritem extends StatelessWidget {
  final Widget icon;
  final String label;
  final void onTap;

  const Draweritem(
      {super.key, required this.label, this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Gives the width
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: const Color.fromARGB(22, 96, 125, 139),
      ),
      margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
      width: double.infinity,
      height: screenHeight * .07,
      child: Center(
          child: Row(
        children: [icon, Text(label), addHorizontalSpace(screenWidth * .3)],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      )),
    );
  }
}
