import 'package:flutter/material.dart';
import 'package:hogwarts_sorting_hat/app_colors.dart';

class NotInHouseBox extends StatelessWidget {
  const NotInHouseBox({super.key, required this.onHouseTap});
  final Function() onHouseTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onHouseTap,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black, width: 2),
          ),
          child: Center(child: Text('Not in House')),
        ),
      ),
    );
  }
}
