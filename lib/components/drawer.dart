import 'package:flutter/material.dart';
import 'package:my_to_do/components/drawerItem.dart';
import 'package:my_to_do/components/misc.dart';
import 'package:my_to_do/pages/about.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_to_do/services/exportServices.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final TextEditingController _nameController = TextEditingController();
  String? userName;
  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
    });
  }

  Future<void> _editName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
    setState() {
      userName = name; // Update UI immediately
    }
  }

  _showEditTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String newName = '';
        return AlertDialog(
          title: Text('Edit name'),
          content: TextField(
            cursorColor: Colors.teal,
            onChanged: (value) {
              newName = value;
            },
            decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors
                          .teal), // Set underline color to teal when focused
                ),
                focusColor: Colors.teal),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newName.isNotEmpty) {
                  _editName(newName);
                  _loadUserName();
                  Navigator.pop(context);
                }
              },
              child: Text(
                'Edit',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: Center(
        child: Column(
          children: [
            addVerticalSpace(screenHeight * .1),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                addHorizontalSpace(15),
                CircleAvatar(
                  //backgroundImage: AssetImage("assets/images/cupcake.png"),
                  backgroundColor: Colors.teal,
                  radius: screenHeight * .04,
                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),
                addHorizontalSpace(15),
                Expanded(
                  child: Text(
                    "$userName",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                GestureDetector(
                    onTap: _showEditTaskDialog, child: Icon(Icons.edit)),
                addHorizontalSpace(screenWidth * .05),
              ],
            ),
            addVerticalSpace(screenHeight * .02),
            GestureDetector(
              child: Draweritem(
                  label: "Export all diaries",
                  icon: Icon(Icons.import_export_rounded),
                  onTap: () => exportDiaries(context)),
            ),
            GestureDetector(
              child: Draweritem(
                label: "Storage permission",
                icon: Icon(Icons.storage),
                onTap: () async {
                  bool granted = await requestFullStoragePermission();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(granted
                          ? "Storage permission granted!"
                          : "Storage permission not granted."),
                    ),
                  );
                }, // Leave empty for now
              ),
            ),
            Draweritem(
              label: "ToDo Archive | soon",
              icon: Icon(Icons.archive_outlined),
              onTap: () {}, // Leave the other onTap actions empty for now
            ),
            Draweritem(
              label: "Mood analysis | soon",
              icon: Icon(Icons.data_saver_off),
              onTap: () {}, // Leave empty for now
            ),
            Draweritem(
              label: "Recycle bin | soon",
              icon: Icon(Icons.delete),
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
          ],
        ),
      ),
    );
  }
}
