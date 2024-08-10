import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/app_constants.dart';
import 'package:hogwarts_sorting_hat/feature/home/repository/home_repository.dart';
import 'package:hogwarts_sorting_hat/models/attempted_character.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository _homeRepository;

  HomeCubit(this._homeRepository) : super(HomeState.initial());

  bool get isLoading => state.status == HomeStatus.loading;

  Future<void> getRandomCharacter() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final character = _homeRepository.getRandomCharacter();
    if (character != null) {
      final image = await getCharacterImage(character.image!);
      final attemptedCharacter = AttemptedCharacter.fromCharacter(character);
      attemptedCharacter.addImageFile = image;
      emit(state.copyWith(
          status: HomeStatus.success, character: () => attemptedCharacter));
    } else {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<File?> getCharacterImage(String? photoUrl) async {
    if (photoUrl?.isEmpty ?? true) return null;
    return await _homeRepository.getCharacterImage(photoUrl!);
  }

  void attempt(House house) {
    final character = state.attemptedCharacters.firstWhere(
      (char) => char.id == state.character?.id,
      orElse: () => state.character!,
    );
    final attemptResult = character.attempt(house);
    if (attemptResult == null) return;
    final attemptedCharacters = [
      ...state.attemptedCharacters.where((char) => char.id != character.id),
      character
    ];
    emit(state.copyWith(
      attemptedCharacters: attemptedCharacters,
      filteredCharacters: attemptedCharacters,
      totalSuccessAttempts:
          state.totalSuccessAttempts + (attemptResult ? 1 : 0),
      totalFailedAttempts: state.totalFailedAttempts + (attemptResult ? 0 : 1),
    ));
  }

  void reset() {
    emit(HomeState.initial());
    getRandomCharacter();
  }

  void reload(AttemptedCharacter character) {
    emit(state.copyWith(
      character: () => character,
    ));
  }

  void filterUsers(String pattern) {
    emit(state.copyWith(
        filteredCharacters: _homeRepository.filterCharacters(
            state.attemptedCharacters, pattern)));
  }
}
