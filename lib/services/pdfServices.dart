import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';

class SaveAndOpenDocument {
  static Future<File> savePdf(
      {required String name, required Document pdf}) async {
    final List<Directory>? directories = await getExternalStorageDirectories();

    if (directories == null || directories.isEmpty) {
      throw Exception("No external storage directories found");
    }

    final Directory dir = directories.first; // Use the first directory
    final String filePath = "${dir.path}/$name";
    final File file = File(filePath);

    await file.writeAsBytes(await pdf.save()); // Save the PDF file
    return file;
  }
}
