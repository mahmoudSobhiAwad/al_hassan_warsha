import 'dart:developer';
import 'dart:io';

Future<String> copyMediaFile(
    String sourcePath, String destinationFolderPath) async {
  try {
    // Get the source file
    final sourceFile = File(sourcePath);

    // Check if the source file exists
    if (!await sourceFile.exists()) {
      throw Exception('Source file does not exist');
    }
 

    // Create the destination folder if it doesn't exist
    final destinationFolder = Directory(destinationFolderPath);
    if (!await destinationFolder.exists()) {
      await destinationFolder.create(recursive: true);
    }

    final fileName = sourceFile.uri.pathSegments.last;
    final fileExtension = fileName.split('.').last;
    final uniqueNumber = DateTime.now().microsecondsSinceEpoch;

    // Construct the destination file path using the unique number
    final destinationFilePath =
        '${destinationFolder.path}${Platform.pathSeparator}$uniqueNumber.$fileExtension';

    // Copy the file
    final destinationFile = await sourceFile.copy(destinationFilePath);

    return destinationFile.path;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<void> deleteMediaFile(String filePath) async {
  try {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      log('File deleted successfully: $filePath');
    } else {
      log('File does not exist: $filePath');
    }
  } catch (e) {
    log(e.toString());
  }
}
