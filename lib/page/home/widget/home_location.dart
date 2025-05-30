import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeLocation extends StatelessWidget {
  const HomeLocation({super.key, required this.namelocation});

  final String namelocation;
  @override
  Widget build(BuildContext context) {
    final df = DateFormat('dd-MM-yyyy');
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/img/icons/location.png'),
            SizedBox(
              width: 10,
            ),
            Text(
              namelocation,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          df.format(DateTime.now()),
          style: TextStyle(
            fontSize: 28,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
