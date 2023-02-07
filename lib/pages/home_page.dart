import 'package:flutter/material.dart';
import 'package:tapshyrma09_flutter/constants/app_colors.dart';
import 'package:tapshyrma09_flutter/constants/app_text_styles.dart';
import 'package:tapshyrma09_flutter/constants/app_texts.dart';

import '../components/icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          AppText.appBarTitle,
          style: AppTextStyles.appBarStyle,
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/weather.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            IconsUI(),
          ],
        ),
      ),
    );
  }
}
