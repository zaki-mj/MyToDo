import 'package:flutter/material.dart';
import 'package:my_to_do/components/drawerItem.dart';
import 'package:my_to_do/components/misc.dart';
import 'package:my_to_do/pages/about.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              label: "ToDo Archive",
              icon: Icon(Icons.archive_outlined),
              onTap: () {}, // Leave the other onTap actions empty for now
            ),
            Draweritem(
              label: "Mood analysis",
              icon: Icon(Icons.data_saver_off),
              onTap: () {}, // Leave empty for now
            ),
            Draweritem(
              label: "Import/Export",
              icon: Icon(Icons.import_export_rounded),
              onTap: () {}, // Leave empty for now
            ),
            Draweritem(
              label: "About",
              icon: Icon(Icons.info_outline),
              onTap: () {
                // Directly navigate to About page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
            addVerticalSpace(screenHeight * .5)
          ],
        ),
      ),
    );
  }
}
