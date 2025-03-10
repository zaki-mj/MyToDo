import 'package:flutter/material.dart';
import 'package:my_to_do/components/drawerItem.dart';
import 'package:my_to_do/components/misc.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // Gives the width
    double screenHeight = MediaQuery.of(context).size.height;
    return Drawer(
      child: Center(
        child: Column(
          children: [
            addVerticalSpace(screenHeight * .1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: screenHeight * .04,
                ),
                Text(
                  "Zakaria",
                  style: TextStyle(fontSize: 20),
                ),
                addHorizontalSpace(screenWidth * .3)
              ],
            ),
            addVerticalSpace(screenHeight * .02),
            Draweritem(
              label: "Coming Soon",
              icon: Icon(Icons.abc),
            ),
            Draweritem(
              label: "Coming Soon",
              icon: Icon(Icons.abc),
            ),
            Draweritem(
              label: "About",
              icon: Icon(Icons.info_outline),
            ),
            addVerticalSpace(screenHeight * .5)
          ],
        ),
      ),
    );
  }
}
