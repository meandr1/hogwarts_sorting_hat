import 'dart:io';

import 'package:hogwarts_sorting_hat/models/attempted_character.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';
import 'package:hogwarts_sorting_hat/services/cache_service/cache_service.dart';
import 'package:hogwarts_sorting_hat/services/files_service/files_service.dart';

class HomeRepository {
  final FilesService filesService;
  final CacheService cacheService;

  HomeRepository({required this.filesService, required this.cacheService});

  Character? getRandomCharacter() {
    return cacheService.getRandomCharacter();
  }

  Future<File?> getCharacterImage(String photoUrl) async {
    return await filesService.getFile(fileUrl: photoUrl);
  }

  List<AttemptedCharacter> filterCharacters(
      List<AttemptedCharacter> characters, String pattern) {
    pattern =
        pattern.trim().replaceAll(RegExp(r' +'), ' ').split(' ').join(')(?=.*');
    List<AttemptedCharacter> filtered = [];
    filtered.addAll(characters.where((character) {
      final matcher = RegExp('(?=.*$pattern)', caseSensitive: false);
      return matcher.hasMatch(character.name);
    }));
    return filtered;
  }
}
