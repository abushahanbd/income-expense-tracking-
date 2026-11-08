import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';
import 'package:money_management/core/constant/app_text.dart';

class CurrentBalanceCard extends StatelessWidget {
  CurrentBalanceCard({super.key, required this.currentBalance});

  String currentBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.10),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
   /* 
     {Shahan}
   */
  
            child: const Icon(
              Icons.account_balance_wallet_rounded,
              color: AppColors.primary,
              size: 30,
            ),
          ),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppText.currentBalance,
                style: TextStyle(fontSize: 12, color: AppColors.textPrimary),
              ),

              SizedBox(height: 3),

              Text(
                '৳${currentBalance}',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
