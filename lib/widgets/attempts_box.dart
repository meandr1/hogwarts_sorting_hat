import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';

class AttemptsBox extends StatelessWidget {
  const AttemptsBox({super.key, required this.text, required this.attempts});

  final String text;
  final int attempts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(attempts.toString()),
              const SizedBox(height: 6),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
