import 'dart:convert';
import 'package:hogwarts_sorting_hat/app_constants.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';
import 'package:hogwarts_sorting_hat/services/cache_service/cache_service.dart';
import 'package:http/http.dart' as http;

class SplashRepository {
  final CacheService _cacheService;

  SplashRepository(this._cacheService);

  Future<void> getCharacters() async {
    final List<Character> characters = [];
    final response = await http.get(Uri.parse(AppConstants.apiUrl));
    if (response.statusCode == 200) {
      final List jsonData = jsonDecode(response.body);
      for (var item in jsonData) {
        characters.add(Character.fromJSON(item));
      }
      await _cacheService.storeCharacters(characters);
    }
  }
}
