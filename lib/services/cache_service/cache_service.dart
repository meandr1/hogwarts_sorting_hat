import 'dart:math';
import 'package:hogwarts_sorting_hat/hive_boxes.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';

class CacheService {
  Character? getRandomCharacter() {
    final charactersCount = charactersBox.length;
    return charactersBox.getAt(Random().nextInt(charactersCount));
  }

  Future<void> storeCharacters(List<Character> characters) async {
    await charactersBox.addAll(characters);
  }
}
