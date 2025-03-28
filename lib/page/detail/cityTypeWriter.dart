import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

class CityTypeWriter extends StatefulWidget {
  final String cityName;
  const CityTypeWriter({super.key, required this.cityName});

  @override
  State<CityTypeWriter> createState() => _CityTypeWriterState();
}

class _CityTypeWriterState extends State<CityTypeWriter> {
  String _currentCity = "";

  @override
  void didUpdateWidget(covariant CityTypeWriter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cityName != oldWidget.cityName) {
      setState(() {
        _currentCity = widget.cityName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return TypeWriterText(
      key: ValueKey(
          _currentCity), // Đảm bảo animation chạy lại khi city thay đổi
      text: Text(
        "$_currentCity City",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      duration: const Duration(milliseconds: 50),
    );
  }
}
