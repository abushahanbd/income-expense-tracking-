import 'package:flutter/material.dart';
import 'package:money_management/core/constant/app_color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onTap;
  final String title;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final Color iconColor;

  CustomAppBar({
    super.key,
    this.onTap,
    this.leftIcon,
    this.rightIcon,
    required this.title,
    this.iconColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      automaticallyImplyLeading: true,

      titleSpacing: 16,

      title: Row(
        children: [
          // Wallet Logo
          Icon(leftIcon, color: iconColor, size: 34),

          const SizedBox(width: 12),

          // App Name
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),

      actions: [
        IconButton(
          onPressed: onTap ?? () {},
          icon: Icon(rightIcon, color: AppColors.textPrimary, size: 24),
        ),

        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
