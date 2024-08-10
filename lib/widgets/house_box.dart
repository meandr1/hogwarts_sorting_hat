import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';

class HouseBox extends StatelessWidget {
  const HouseBox(
      {super.key,
      required this.houseName,
      required this.child,
      required this.onHouseTap});

  final String houseName;
  final Widget child;
  final Function() onHouseTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onHouseTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 28,
                height: 28,
                child: child),
              const SizedBox(height: 5),
              Text(houseName),
            ],
          ),
        ),
      ),
    );
  }
}
