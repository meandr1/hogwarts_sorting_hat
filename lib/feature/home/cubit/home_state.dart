part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final AttemptedCharacter? character;
  final int totalSuccessAttempts;
  final int totalFailedAttempts;
  final List<AttemptedCharacter> attemptedCharacters;
  final List<AttemptedCharacter> filteredCharacters;

  const HomeState({
    required this.filteredCharacters,
    required this.attemptedCharacters,
    this.totalSuccessAttempts = 0,
    this.totalFailedAttempts = 0,
    required this.status,
    this.character,
  });

  factory HomeState.initial() {
    return const HomeState(
      filteredCharacters: [],
      attemptedCharacters: [],
      status: HomeStatus.initial,
    );
  }

  HomeState copyWith(
      {HomeStatus? status,
      AttemptedCharacter Function()? character,
      int? totalSuccessAttempts,
      List<AttemptedCharacter>? attemptedCharacters,
      List<AttemptedCharacter>? filteredCharacters,
      int? totalFailedAttempts}) {
    return HomeState(
      filteredCharacters: filteredCharacters ?? this.filteredCharacters,
      attemptedCharacters: attemptedCharacters ?? this.attemptedCharacters,
      totalSuccessAttempts: totalSuccessAttempts ?? this.totalSuccessAttempts,
      totalFailedAttempts: totalFailedAttempts ?? this.totalFailedAttempts,
      status: status ?? this.status,
      character: character!= null ? character() : this.character,
    );
  }

  @override
  List<Object?> get props => [
        status,
        character,
        totalSuccessAttempts,
        totalFailedAttempts,
        filteredCharacters,
        attemptedCharacters
      ];
}
