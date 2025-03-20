import 'package:flutter/material.dart';
import 'package:my_to_do/components/misc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final String githubUrl = "https://github.com/zaki-mj/MyToDo";

    Future<void> _launchURL(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        throw Exception("Could not launch $url");
      }
    }

    Future<void> requestStoragePermission() async {
      PermissionStatus status = await Permission.storage.request();

      if (status.isGranted) {
        print("Storage permission granted");
      } else if (status.isDenied) {
        print("Storage permission denied");
      } else if (status.isPermanentlyDenied) {
        print("Storage permission permanently denied, open app settings");
        openAppSettings();
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenHeight * .05),
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo.png',
                scale: 3,
              ),
              addVerticalSpace(screenHeight * .05),
              Text(
                'MEE - ToDo & Diary',
                style: TextStyle(
                    color: Colors.tealAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              addVerticalSpace(screenHeight * .01),
              Text(
                'MEE is a free and open source\nDiary and ToDo manager made in\nflutter with local storage functionality',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
              addVerticalSpace(screenHeight * .025),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blueGrey[900],
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: screenHeight * .05,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "1.2.0",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      Text(
                        "10-03-2025",
                        style: TextStyle(color: Colors.white),
                      ),
                      addHorizontalSpace(screenWidth * .3),
                    ],
                  ),
                ),
              ),
              addVerticalSpace(screenHeight * .025),
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 44, 44, 44),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                height: screenHeight * .20,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Author:",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.teal),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          addHorizontalSpace(screenWidth * .1),
                          CircleAvatar(
                            backgroundColor: Colors.teal,
                            radius: screenHeight * .03,
                            backgroundImage:
                                AssetImage("assets/images/pfp.png"),
                          ),
                          Text(
                            "Zakaria M.",
                            style: TextStyle(fontSize: 20),
                          ),
                          addHorizontalSpace(screenWidth * .1),
                        ],
                      ),
                      addVerticalSpace(screenHeight * .005),
                      Container(
                        color: Colors.grey,
                        height: 2,
                        width: screenWidth * .6,
                      ),
                      addVerticalSpace(screenHeight * .01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          addHorizontalSpace(screenWidth * .02),
                          GestureDetector(
                            onTap: () => _launchURL(githubUrl),
                            child: Image.asset(
                              "assets/images/github.png",
                              scale: 7.5,
                              color: Colors.teal,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => _launchURL(
                                "https://www.facebook.com/zakariamjd.911"),
                            child: Icon(
                              Icons.facebook,
                              size: screenHeight * .05,
                              color: Colors.teal,
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                _launchURL("mailto:mz.medjdoub@esi-sba.dz"),
                            child: Icon(
                              Icons.mail_outline_rounded,
                              size: screenHeight * .05,
                              color: Colors.teal,
                            ),
                          ),
                          addHorizontalSpace(screenWidth * .02),
                        ],
                      ),
                      addVerticalSpace(screenHeight * .01),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
