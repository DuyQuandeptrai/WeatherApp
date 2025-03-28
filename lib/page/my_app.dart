import 'package:appweather/apps/config/theme_custom.dart';
import 'package:appweather/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_custom/bottom_custom.dart';
//import 'home/home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.positionCurrent});
  final Position positionCurrent;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      // cung cap 1 provider de quan ly trang thai
      create: (_) => WeatherProvider()
        ..updatePosition(positionCurrent), // khoi tao weatherprovider
      child: MaterialApp(
        theme: ThemeCustom.themeLight,
        debugShowCheckedModeBanner: false,
        home: BottomCustom(),
      ),
    );
  }
}
