import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';

class customStatsfilter extends StatelessWidget {
  const customStatsfilter({
    super.key,
    required this.isSelected,
    required this.period
  });

  final bool isSelected;
  final String period;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      alignment: Alignment.center,
      child: Text(
        period,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isSelected
              ? Colors.white
              : AppColors.textPrimary,
        ),
      ),
    );
  }
}
