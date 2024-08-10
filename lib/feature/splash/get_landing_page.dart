import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/feature/home/home_screen.dart';
import 'package:hogwarts_sorting_hat/feature/splash/cubit/splash_cubit.dart';
import 'package:hogwarts_sorting_hat/feature/splash/splash_screen.dart';

class GetLandingPage extends StatelessWidget {
  const GetLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isCharactersEmpty = context.read<SplashCubit>().isCharactersEmpty;
    if (isCharactersEmpty) {
      context.read<SplashCubit>().getCharacters();
      return const SplashScreen();
    } else {
      return const HomeScreen();
    }
  }
}
