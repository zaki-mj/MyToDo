// lib/utils/export_utils.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_to_do/global.dart'; // to access myDiaries

Future<bool> requestFullStoragePermission() async {
  if (await Permission.manageExternalStorage.isGranted) return true;

  PermissionStatus status = await Permission.manageExternalStorage.request();

  if (status.isGranted) {
    print("✅ Full storage permission granted.");
    return true;
  } else if (status.isDenied) {
    print("❌ Storage permission denied.");
  } else if (status.isPermanentlyDenied) {
    print("⚠️ Storage permission permanently denied. Opening settings...");
    await openAppSettings();
  }

  return false;
}

Future<void> exportDiaries(BuildContext context) async {
  if (myDiaries.isEmpty) {
    print("No diaries to export!");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("No diaries to export.")),
    );
    return;
  }

  // Request storage permission
  bool permissionGranted = await requestFullStoragePermission();
  if (!permissionGranted) {
    return;
  }

  // Define the export directory
  final customDir = Directory('/storage/emulated/0/Documents/Mee');

  // Create directory if it doesn't exist
  if (!await customDir.exists()) {
    await customDir.create(recursive: true);
    print("✅ Custom directory created: ${customDir.path}");
  }

  // Export each diary as a separate .txt file
  for (var diary in myDiaries) {
    // Sanitize title to use in filename
    String safeTitle = diary.title
        .replaceAll(
            RegExp(r'[\\/:*?"<>|]'), '_') // Replace illegal filename chars
        .trim();

    // Fall back to a default name if title is empty
    if (safeTitle.isEmpty) {
      safeTitle = "untitled_${DateTime.now().millisecondsSinceEpoch}";
    }

    final file = File('${customDir.path}/$safeTitle.txt');
    final content = diary.body;
    await file.writeAsString(content);
  }

  // Show success message
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text("✅ Diaries exported to: ${customDir.path}"),
      duration: const Duration(seconds: 3),
    ),
  );
}
