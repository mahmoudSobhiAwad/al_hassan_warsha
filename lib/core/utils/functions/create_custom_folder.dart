import 'dart:developer';
import 'dart:io';

void createFolder(String path) async {
  final directory = Directory(path);

  if (await directory.exists()) {
    log('Folder already exists at $path');
  } else {
    try {
      await directory.create(recursive: true);
      log('Folder created at $path');
    } catch (e) {
      log('Error creating folder: $e');
    }
  }
}