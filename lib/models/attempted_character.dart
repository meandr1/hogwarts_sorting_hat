import 'dart:io';
import 'package:hogwarts_sorting_hat/app_constants.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';

class AttemptedCharacter extends Character {
  int successAttempt;
  int failedAttempts;
  File? imageFile;

  AttemptedCharacter({
    required super.id,
    required super.name,
    super.house,
    super.dateOfBirth,
    super.actor,
    super.image,
    super.species,
    super.gender,
    this.imageFile,
    this.successAttempt = 0,
    this.failedAttempts = 0,
  });

  factory AttemptedCharacter.fromCharacter(Character character) {
    return AttemptedCharacter(
        id: character.id,
        name: character.name,
        house: character.house,
        dateOfBirth: character.dateOfBirth,
        actor: character.actor,
        image: character.image,
        species: character.species,
        gender: character.gender);
  }

  set addImageFile(File? image) {
    imageFile = image;
  }

  get totalAttempts => successAttempt + failedAttempts;

  get isGuessed => successAttempt == 1;

  bool? attempt(House house) {
    if (successAttempt == 1) return null;
    final isCorrectHouse = this.house == house.name;
    if (isCorrectHouse) {
      successAttempt++;
      return true;
    } else {
      failedAttempts++;
      return false;
    }
  }

  @override
  operator ==(Object other) {
    return other is AttemptedCharacter &&
        other.id == id &&
        other.name == name &&
        other.house == house &&
        other.dateOfBirth == dateOfBirth &&
        other.actor == actor &&
        other.image == image &&
        other.species == species &&
        other.gender == gender;
  }

  @override
  int get hashCode {
    return Object.hash(
        id, name, house, dateOfBirth, actor, image, species, gender);
  }
}
