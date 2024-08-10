import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class RemoteFilesService {

  Future<File?> getFile({required String fileUrl}) async {
    if (fileUrl.isEmpty) return null;
    try {
      return await DefaultCacheManager().getSingleFile(fileUrl);
    } catch (e) {
      return null;
    }
  }

}
