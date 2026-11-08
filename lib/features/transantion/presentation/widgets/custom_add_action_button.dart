import 'package:flutter/material.dart';

class CustomAddActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const CustomAddActionButton({
    super.key,
    required this.onPressed,
    this.backgroundColor = const Color(
      0xFF00A843,
    ), // Matches your app's green theme
    this.icon = Icons.add,
    this.iconColor = Colors.white,
    this.iconSize = 28.0,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      shape: const CircleBorder(),
      child: Icon(icon, color: iconColor, size: iconSize),
    );
  }
}
