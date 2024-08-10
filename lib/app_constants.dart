enum House { gryffindor, slytherin, ravenclaw, hufflepuff, NotInHouse }

extension HouseName on House {
  String get name {
    switch (this) {
      case House.gryffindor:
        return 'Gryffindor';
      case House.slytherin:
        return 'Slytherin';
      case House.ravenclaw:
        return 'Ravenclaw';
      case House.hufflepuff:
        return 'Hufflepuff';
      case House.NotInHouse:
        return '';
    }
  }
}

abstract class AppConstants {
  static const String apiUrl = 'https://hp-api.onrender.com/api/characters';
  static const String errorLoadingCharacters =
      'Something went wrong while loading characters';

  static const int searchDelay = 800;
}
