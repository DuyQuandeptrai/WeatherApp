import 'package:appweather/apps/utils/asset.dart';
import 'package:flutter/material.dart';

class HomeWeatherIcon extends StatelessWidget {
  const HomeWeatherIcon({super.key, required this.nameIcon});
  final String nameIcon;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width / 1.7,
      padding: EdgeInsets.all(20),
      child: Image.asset(
        AssetCustom.getlinkImg(nameIcon),
        fit: BoxFit.cover,
      ),
    );
  }
}
