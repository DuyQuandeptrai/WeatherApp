import 'package:appweather/models/weather.dart';
import 'package:appweather/page/home/widget/home_detail.dart';
import 'package:appweather/page/home/widget/home_location.dart';
import 'package:appweather/page/home/widget/home_temperature.dart';
import 'package:appweather/page/home/widget/home_weather_icon.dart';
import 'package:appweather/provider/weather_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WeatherProvider>().fetchWeather()); // Gọi API 1 lần
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [const Color.fromARGB(255, 0, 23, 196), Colors.lightBlue],
          ),
        ),
        child: Consumer<WeatherProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading || provider.currentWeather == null) {
              return Center(child: CircularProgressIndicator());
            }

            WeatherData data = provider.currentWeather!;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                HomeWeatherIcon(nameIcon: data.weather[0].main),
                HomeTemperature(temp: data.main.temp),
                HomeLocation(namelocation: data.name),
                SizedBox(height: 40),
                HomeDetail(
                  namehumidity: data.main.humidity,
                  namespeed: data.wind.speed,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
