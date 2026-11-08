import 'package:flutter/material.dart';

class ActionButtonsRow extends StatelessWidget {
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const ActionButtonsRow({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildButton(
            text: 'Edit',
            icon: Icons.edit_rounded,
            backgroundColor: const Color(0xFFE2F6EA),
            textColor: const Color(0xFF00A843),
            onTap: onEditPressed,
          ),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: _buildButton(
            text: 'Delete',
            icon: Icons.delete_outline_rounded,
            backgroundColor: const Color(0xFFFFEAEA),
            textColor: const Color(0xFFDC2626),
            onTap: onDeletePressed,
          ),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String text,
    required IconData icon,
    required Color backgroundColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0),
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 20.0,
            ),
            const SizedBox(width: 8.0),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
