import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const linkAsset = 'assets/img/weather/';

class AssetCustom {
  static final Map<String, String> weatherIcons = {
    'rain': 'heavyrain.png',
    'clear': 'clear.png',
    'clouds': 'clouds.png',
    'snow': 'snow.png',
  };

  static String getlinkImg(String name) {
    // Tìm trong danh sách ánh xạ, nếu không có thì dùng mặc định
    String iconFile = weatherIcons[name.toLowerCase()] ??
        '${name.replaceAll(' ', '').toLowerCase()}.png';
    return '$linkAsset$iconFile';
  }
}

Widget createTemp(num temp, {double size = 100}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        temp.round().toString(),
        style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      Text(
        '0',
        style: TextStyle(
          fontSize: size / 3,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ],
  );
}
