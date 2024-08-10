import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/hive_boxes.dart';
import 'package:hogwarts_sorting_hat/models/character_model.dart';
import 'package:hogwarts_sorting_hat/feature/splash/repository/splash_repository.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashRepository _splashRepository;

  SplashCubit(this._splashRepository) : super(SplashState.initial());

  bool get isCharactersEmpty => charactersBox.isEmpty;

  void getCharacters() async {
    try {
      await _splashRepository.getCharacters();
      emit(state.copyWith(status: SplashStatus.success));
    } catch (e) {
      emit(state.copyWith(status: SplashStatus.error));
    }
  }
}
