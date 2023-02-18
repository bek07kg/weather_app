import 'package:flutter/material.dart';
import 'package:tapshyrma09_flutter/pages/home_page.dart';

class ToguzunchuTapshyrma extends StatelessWidget {
  const ToguzunchuTapshyrma({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Weather App",
      home: HomePage(),
    );
  }
}
