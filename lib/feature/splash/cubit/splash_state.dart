part of 'splash_cubit.dart';

enum SplashStatus { initial, success, error }

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({
    required this.status,
  });

  factory SplashState.initial() {
    return const SplashState(
      status: SplashStatus.initial,
    );
  }

  SplashState copyWith({List<Character>? characters, SplashStatus? status}) {
    return SplashState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
