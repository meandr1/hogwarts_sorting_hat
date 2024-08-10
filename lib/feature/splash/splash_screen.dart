import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';
import 'package:hogwarts_sorting_hat/app_constants.dart';
import 'package:go_router/go_router.dart';
import 'package:hogwarts_sorting_hat/feature/splash/cubit/splash_cubit.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.success) {
          context.go('/HomeScreen');
        } else if (state.status == SplashStatus.error) {
          Flushbar(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  margin: const EdgeInsets.all(16),
                  backgroundColor: AppColors.flushbarBackground,
                  duration: const Duration(seconds: 3),
                  message: AppConstants.errorLoadingCharacters,
                  flushbarPosition: FlushbarPosition.TOP)
              .show(context)
              .then((_) => context.go('/HomeScreen'));
        }
      },
      child: SizedBox.expand(
        child: Container(
          color: AppColors.backgroundPrimary,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Loading Characters...',
                style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
              Lottie.asset(
                'assets/animations/golden_snitch.json',
                repeat: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
