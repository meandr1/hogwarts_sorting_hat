import 'dart:io';
import 'package:hogwarts_sorting_hat/hive_boxes.dart';
import 'package:path_provider/path_provider.dart';

class LocalFilesService{

  File? getFile({required String fileUrl}) {
    final path = filesBox.get(fileUrl);
    if (path == null) return null;
    return File(path);
  }

  Future<void> storeFile({required File file, required String fileUrl}) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    final fileName = getFileNameFromURL(fileUrl);
    final destPath = '${appDocumentsDir.path}/$fileName';
    await file.copy(destPath);
    await filesBox.put(fileUrl, destPath);
  }

    String getFileNameFromURL(String fileURL) {
    return fileURL.substring(
        fileURL.lastIndexOf('/') + '/'.length);
  }
}
