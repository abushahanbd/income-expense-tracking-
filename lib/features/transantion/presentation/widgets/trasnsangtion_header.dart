import 'package:flutter/material.dart';

class TransactionHeader extends StatelessWidget {
  final String title;
  final String amount;
  final bool isIncome;

  const TransactionHeader({
    super.key,
    required this.title,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final color = isIncome ? const Color(0xFF00A651) : Colors.red;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncome
                  ? Icons.account_balance_wallet
                  : Icons.shopping_bag_outlined,
              size: 36,
              color: color,
            ),
          ),

          const SizedBox(height: 5),

          // Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF171B2D),
            ),
          ),

          const SizedBox(height: 2),

          // Amount
          Text(
            '${isIncome ? '+' : '-'}৳$amount',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          const SizedBox(height: 4),

          // Income / Expense Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isIncome ? Icons.arrow_upward : Icons.arrow_downward,
                  size: 16,
                  color: color,
                ),
                const SizedBox(width: 5),
                Text(
                  isIncome ? 'Income' : 'Expense',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
