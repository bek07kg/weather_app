import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class IconsUI extends StatelessWidget {
  const IconsUI({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.navigation,
          color: AppColors.white,
          size: 60,
        ),
        SizedBox(width: 280),
        Icon(
          Icons.location_city,
          color: AppColors.white,
          size: 60,
        ),
      ],
    );
  }
}
