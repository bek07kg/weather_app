import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IconsUI extends StatelessWidget {
  const IconsUI({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 60,
      color: AppColors.white,
      icon: Icon(
        icon,
      ),
    );
  }
}
