import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';

class TransactionListTile extends StatelessWidget {
  final String title;
  final String category;
  final String amount;
  final String date;
  final bool isIncome;
  final IconData icon;
  final VoidCallback? onTap;

  const TransactionListTile({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    this.isIncome = true,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color transactionColor = isIncome
        ? AppColors.income
        : AppColors.expense;

    return Card(
      elevation: .00021,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              // Category Icon
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: transactionColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isIncome
                      ? Icons.arrow_downward_outlined
                      : Icons.arrow_upward_outlined,
                  color: transactionColor,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              // Title and Category
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Amount and Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${isIncome ? '+' : '-'}৳$amount',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: transactionColor,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
