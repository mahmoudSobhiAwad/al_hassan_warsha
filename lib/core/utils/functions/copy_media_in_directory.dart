import 'dart:developer';
import 'dart:io';
import 'package:al_hassan_warsha/core/utils/functions/save_paths.dart';
import 'package:al_hassan_warsha/features/gallery/data/models/kitchen_model.dart';
import 'package:al_hassan_warsha/features/home/data/constants.dart';

Future<String> copyMediaFile(String sourcePath, String destinationFolderPath,
    {required String mediId}) async {
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

    // Construct the destination file path using the unique number
    final destinationFilePath =
        '${destinationFolder.path}${Platform.pathSeparator}$mediId.$fileExtension';

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

Future<void> deleteTempMediaFile(
    String mediaId, String mediaMainPath, MediaType mediaType) async {
  try {
    final sourceFile = File(mediaMainPath);
    final fileName = sourceFile.uri.pathSegments.last;
    final fileExtension = fileName.split('.').last;

    final String destinationFolder = SharedPrefHelper.fetchPathFromShared(
            mediaType == MediaType.image ? imageTempPath : videoTempPath) ??
        "";
    // Construct the destination file path using the unique number
    final File deletedFile = File(
        '$destinationFolder${Platform.pathSeparator}$mediaId.$fileExtension');

    if (await deletedFile.exists()) {
      await deletedFile.delete();
      log('File deleted successfully: ${deletedFile.path}');
    } else {
      log('File does not exist: ${deletedFile.path}');
    }
  } catch (e) {
    log(e.toString());
  }
}
