import 'package:flutter/material.dart';

class TransactionTypeButtons extends StatelessWidget {
  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  const TransactionTypeButtons({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            text: 'Income',
            icon: Icons.arrow_upward_rounded,
            isSelected: selectedType == 'Income',
            activeBgColor: const Color(0xFFE2F6EA),
            activeColor: const Color(0xFF00A843),
            onTap: () => onTypeChanged('Income'),
          ),
        ),
        const SizedBox(width: 12.0),

        Expanded(
          child: _buildButton(
            text: 'Expense',
            icon: Icons.arrow_downward_rounded,
            isSelected: selectedType == 'Expense',
            activeBgColor: const Color(0xFFE2F6EA),
            activeColor: const Color(0xFF1E293B),
            onTap: () => onTypeChanged('Expense'),
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required bool isSelected,
    required Color activeBgColor,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          color: isSelected ? activeBgColor : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(100), // রাউন্ড ক্যাপসুল শেপ
          border: Border.all(
            color: isSelected ? Colors.transparent : const Color(0xFFE2E8F0),
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : const Color(0xFF64748B),
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                color: isSelected ? activeColor : const Color(0xFF64748B),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
