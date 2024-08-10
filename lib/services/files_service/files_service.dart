import 'dart:async';
import 'dart:io' show File;
import 'package:hogwarts_sorting_hat/services/files_service/local_files_service.dart';
import 'package:hogwarts_sorting_hat/services/files_service/remote_files_service.dart';

class FilesService {
  final LocalFilesService localFilesService;
  final RemoteFilesService remoteFilesService;

  FilesService(
      {required this.localFilesService, required this.remoteFilesService});

  FutureOr<File?> getFile({required String fileUrl}) async {
    try {
      final localFile = localFilesService.getFile(fileUrl: fileUrl);
      if (localFile != null) return localFile;
      final remoteFile =
          await remoteFilesService.getFile(fileUrl: fileUrl);
      if (remoteFile == null) return null;
      await localFilesService.storeFile(file: remoteFile, fileUrl: fileUrl);
      return remoteFile;
    } catch (e) {
      return null;
    }
  }
}
