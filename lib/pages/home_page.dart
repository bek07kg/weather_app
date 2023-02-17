import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tapshyrma09_flutter/constants/api.dart';
import 'package:tapshyrma09_flutter/constants/app_colors.dart';
import 'package:tapshyrma09_flutter/constants/app_text_styles.dart';
import 'package:tapshyrma09_flutter/constants/app_texts.dart';

import '../components/icons.dart';
import '../model/weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> weatherLocation() {}

  Future<Weather?>? fetchData() async {
    final dio = Dio();
    final responce = await dio.get(Api.api);
    print(responce);
    if (responce.statusCode == 200) {
      final Weather weather = Weather(
        temp: responce.data['main']['temp'],
        description: responce.data['weather'][0]['description'],
        icon: responce.data['weather'][0]['icon'],
        name: responce.data['name'],
      );
      return weather;
    } else {
      return null;
    }
  }

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
      body: FutureBuilder<Weather?>(
          future: fetchData(),
          builder: (context, sn) {
            if (sn.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (sn.connectionState == ConnectionState.none) {
              return Text("Internet connection is unstable! log in again.");
            } else if (sn.connectionState == ConnectionState.done) {
              if (sn.hasError) {
                return Text("${sn.error}");
              } else if (sn.hasData) {
                final weather = sn.data!;

                return Container(
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
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconsUI(
                            icon: Icons.near_me,
                          ),
                          IconsUI(
                            icon: Icons.location_city,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 20),
                          Text(
                            "${(weather.temp - 273.15).truncate()}",
                            style: AppTextStyles.temp,
                          ),
                          Image.network(Api.getIcon(weather.icon, 4)),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(height: 20),
                          Expanded(
                            flex: 3,
                            child: Text(
                              weather.description.replaceAll(" ", "\n"),
                              // "You'all need and ".replaceAll(" ", "\n"),
                              style: AppTextStyles.centertitle,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          weather.name,
                          style: AppTextStyles.city,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Text("Unknown error!");
              }
            } else {
              return const Text("Unknown error!");
            }
          }),
    );
  }
}
