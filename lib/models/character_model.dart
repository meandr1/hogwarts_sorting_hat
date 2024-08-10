import 'package:hive_flutter/hive_flutter.dart';

part 'character_model.g.dart';

@HiveType(typeId: 1)
class Character {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? house;
  @HiveField(3)
  final String? dateOfBirth;
  @HiveField(4)
  final String? actor;
  @HiveField(5)
  final String? image;
  @HiveField(6)
  final String? species;
  @HiveField(7)
  final String? gender;

  Character({
    required this.id,
    required this.name,
    this.house,
    this.dateOfBirth,
    this.actor,
    this.image,
    this.species,
    this.gender,
  });

  factory Character.fromJSON(Map<String, dynamic> jsonData) {
    return Character(
      id: jsonData['id'],
      name: jsonData['name'],
      house: jsonData['house'],
      dateOfBirth: jsonData['dateOfBirth'],
      actor: jsonData['actor'],
      image: jsonData['image'],
      species: jsonData['species'],
      gender: jsonData['gender'],
    );
  }
}
