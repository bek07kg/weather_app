import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IconsUI extends StatelessWidget {
  const IconsUI({
    super.key,
    required this.icon,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      iconSize: 60,
      color: AppColors.white,
      icon: Icon(
        icon,
      ),
    );
  }
}
