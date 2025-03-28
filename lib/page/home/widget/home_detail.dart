import 'package:flutter/material.dart';

class HomeDetail extends StatelessWidget {
  const HomeDetail(
      {super.key, required this.namehumidity, required this.namespeed});
  final num namehumidity;
  final num namespeed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            Image.asset('assets/img/icons/Vector.png'),
            Text(
              '${namespeed.round().toString()} Km/h',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
        Column(
          children: [
            Image.asset('assets/img/icons/humidity.png'),
            Text(
              '${namehumidity.toString()} %',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            )
          ],
        ),
      ],
    );
  }
}
