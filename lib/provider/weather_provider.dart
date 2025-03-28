import 'package:appweather/models/weather.dart';
import 'package:appweather/repositories/api.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class WeatherProvider extends ChangeNotifier {
  Position? position;
  String nameCity = 'Ho Chi Minh';
  WeatherData? currentWeather;
  List<WeatherDetail> weatherForecast = [];
  bool isLoading = false; // Trạng thái loading

  /// 🏙 **Cập nhật vị trí hiện tại**
  void updatePosition(Position positionCurrent) {
    position = positionCurrent;
    notifyListeners();
  }

  /// 🌤 **Lấy thời tiết hiện tại**
  Future<void> fetchWeather({String? cityName}) async {
    isLoading = true; // Bắt đầu load
    notifyListeners();
    try {
      if (cityName != null) {
        nameCity = cityName;
        currentWeather = await Api.callApi(cityName: cityName);
      } else if (position != null) {
        currentWeather = await Api.callApi(position: position);
        nameCity = currentWeather!.name;
      } else {
        throw Exception("Chưa có vị trí hoặc tên thành phố!");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu thời tiết: $e");
    }
    isLoading = false; // Dừng load
    notifyListeners();
  }

  /// 📅 **Lấy dự báo thời tiết 5 ngày**
  Future<void> fetchWeatherDetail({String? cityName}) async {
    isLoading = true;
    notifyListeners();
    try {
      if (cityName != null) {
        weatherForecast = await Api.callApiDetail(cityName: cityName);
      } else if (position != null) {
        weatherForecast = await Api.callApiDetail(position: position);
      } else {
        throw Exception("Chưa có vị trí hoặc tên thành phố!");
      }
    } catch (e) {
      print("Lỗi khi lấy dữ liệu dự báo: $e");
    }
    isLoading = false;
    notifyListeners();
  }
}
