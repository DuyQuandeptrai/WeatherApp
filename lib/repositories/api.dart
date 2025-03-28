import 'package:appweather/models/weather.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';

class Api {
  static const String apiKey = "19ac7829a869247d650a1a27417d1020";
  static final Dio dio = Dio();

  /// 🌤 **Hàm lấy dữ liệu thời tiết hiện tại**
  static Future<WeatherData> callApi(
      {Position? position, String? cityName}) async {
    try {
      String url;

      if (cityName != null) {
        url =
            'https://api.openweathermap.org/data/2.5/weather?q=$cityName&units=metric&appid=$apiKey';
      } else if (position != null) {
        url =
            'https://api.openweathermap.org/data/2.5/weather?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey';
      } else {
        throw Exception("Không có dữ liệu để lấy thời tiết");
      }

      final res = await dio.get(url);
      return WeatherData.fromMap(res.data);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      print("❌ Lỗi không xác định: $e");
      rethrow;
    }
  }

  /// 📅 **Hàm lấy dữ liệu dự báo 5 ngày**
  static Future<List<WeatherDetail>> callApiDetail(
      {Position? position, String? cityName}) async {
    try {
      String url;

      if (cityName != null) {
        url =
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&units=metric&appid=$apiKey';
      } else if (position != null) {
        url =
            'https://api.openweathermap.org/data/2.5/forecast?lat=${position.latitude}&lon=${position.longitude}&units=metric&appid=$apiKey';
      } else {
        throw Exception("Không có dữ liệu để lấy dự báo thời tiết");
      }

      final res = await dio.get(url);
      List<dynamic> dataList = res.data['list'] ?? [];

      return dataList.map((e) => WeatherDetail.fromMap(e)).toList();
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      print("❌ Lỗi không xác định: $e");
      rethrow;
    }
  }

  /// 🚨 **Xử lý lỗi từ API**
  static _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response!.statusCode) {
        case 404:
          throw Exception("❌ Không tìm thấy địa điểm.");
        case 429:
          throw Exception("⚠️ Quá nhiều yêu cầu, hãy thử lại sau.");
        case 500:
          throw Exception("💥 Lỗi máy chủ, vui lòng thử lại.");
        default:
          throw Exception("Lỗi API: ${e.response!.statusCode}");
      }
    } else {
      throw Exception("🚫 Không thể kết nối đến máy chủ.");
    }
  }
}
