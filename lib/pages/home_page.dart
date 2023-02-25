import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tapshyrma09_flutter/constants/api.dart';
import 'package:tapshyrma09_flutter/constants/app_colors.dart';
import 'package:tapshyrma09_flutter/constants/app_text_styles.dart';
import 'package:tapshyrma09_flutter/constants/app_texts.dart';

import '../components/icons.dart';
import '../model/weather.dart';

const List cityes = <String>[
  'bishkek',
  'talas',
  'naryn',
  'batken',
  'jalal-abad',
  'kara-suu'
];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Weather? weather;

  Future<void> weatherLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always &&
          permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();

        final dio = Dio();
        final response = await dio
            .get(Api.getLocator(position.latitude, position.longitude));

        if (response.statusCode == 200) {
          weather = Weather(
              temp: response.data['current']['temp'],
              description: response.data['current']['weather'][0]
                  ['description'],
              icon: response.data['current']['weather'][0]['icon'],
              name: response.data['timezone']);
          setState(() {});
        }
      }
    } else {
      Position position = await Geolocator.getCurrentPosition();

      final dio = Dio();
      final responce =
          await dio.get(Api.getLocator(position.latitude, position.longitude));

      if (responce.statusCode == 200) {
        final Weather weather = Weather(
          temp: responce.data['current']['temp'],
          description: responce.data['current']['weather'][0]['description'],
          icon: responce.data['current']['weather'][0]['icon'],
          name: responce.data['timezone'],
        );
        setState(() {});
      }
    }
  }

  Future<void> weatherName([String? name]) async {
    final dio = Dio();
    final response = await dio.get(Api.api(name ?? 'osh'));

    if (response.statusCode == 200) {
      weather = Weather(
        temp: response.data['main']['temp'],
        description: response.data['weather'][0]['description'],
        icon: response.data['weather'][0]['icon'],
        name: response.data['name'],
      );
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    weatherName();
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
        body: weather == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconsUI(
                          onPressed: () async {
                            await weatherLocation();
                          },
                          icon: Icons.near_me,
                        ),
                        IconsUI(
                          onPressed: () {
                            print("hhhhh");
                            setState(() {
                              showBottom();
                            });
                          },
                          icon: Icons.location_city,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "${(weather!.temp - 273.15).truncate()}",
                          style: AppTextStyles.temp,
                        ),
                        Image.network(Api.getIcon(weather!.icon, 4)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 10),
                        Expanded(
                          flex: 3,
                          child: Text(
                            weather!.description.replaceAll(" ", "\n"),
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
                        weather!.name,
                        style: AppTextStyles.city,
                      ),
                    ),
                  ],
                ),
              ));
  }

  void showBottom() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          color: Colors.yellow,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: cityes.length,
            itemBuilder: (BuildContext context, int index) {
              final city = cityes[index];
              return Card(
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      weather = null;
                    });
                    weatherName(city);
                    Navigator.pop(context);
                  },
                  title: Text(city),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
