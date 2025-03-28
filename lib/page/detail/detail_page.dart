import 'package:appweather/page/detail/detail_body.dart';
import 'package:appweather/provider/weather_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData(); // Gọi API khi trang được mở
  }

  Future<void> _fetchData() async {
    await context.read<WeatherProvider>().fetchWeatherDetail();
    setState(() {
      _isLoading = false;
    });
  }

  void _startSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  void _cancelSearch() {
    setState(() {
      _isSearching = false;
      _searchController.clear();
    });
  }

  void _submitSearch(BuildContext context) {
    final cityName = _searchController.text.trim();
    if (cityName.isNotEmpty) {
      setState(() {
        _isLoading = true; // Hiển thị loading khi gọi API
      });

      context
          .read<WeatherProvider>()
          .fetchWeather(cityName: cityName)
          .then((_) {
        context.read<WeatherProvider>().fetchWeatherDetail(cityName: cityName);
        _cancelSearch();
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 23, 196),
            Colors.lightBlue,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent, // Đảm bảo nền trong suốt
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: _isSearching
              ? TextField(
                  controller: _searchController,
                  autofocus: true,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Nhập tên thành phố...",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) => _submitSearch(context),
                )
              : Row(
                  children: [
                    Icon(CupertinoIcons.location, color: Colors.white),
                    SizedBox(width: 15),
                    TypeWriter.text(
                        key: ValueKey(context
                            .watch<WeatherProvider>()
                            .nameCity), // Reset animation khi tên thành phố thay đổi
                        '${context.watch<WeatherProvider>().nameCity} City',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        duration: const Duration(milliseconds: 50)),
                  ],
                ),
          actions: [
            _isSearching
                ? IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: _cancelSearch,
                  )
                : IconButton(
                    icon: Icon(CupertinoIcons.search, color: Colors.white),
                    onPressed: _startSearch,
                  ),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator()) // Hiển thị loading
            : Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  if (provider.weatherForecast.isEmpty) {
                    return Center(
                      child: Text(
                        "Không có dữ liệu!",
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return DetailBody(listdata: provider.weatherForecast);
                },
              ),
      ),
    );
  }
}
