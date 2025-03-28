import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class Weather {
  int id;
  String main;
  String description;

  Weather({
    required this.id,
    required this.main,
    required this.description,
  });

  // 1️⃣ Chuyển một chuỗi JSON cua api thành MAP(Dùng khi nhận API trả về)
  factory Weather.fromJson(String source) => Weather.fromMap(
      json.decode(source) as Map<String, dynamic>); // luc nay dang o dang map

  // 2️⃣ Chuyển một Map thành Object Weather (Dùng khi dữ liệu JSON đã được decode thành Map)
  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      id: map['id'] as int, // Lấy giá trị id từ Map
      main: map['main'] as String, // Lấy giá trị main từ Map
      description:
          map['description'] as String, // Lấy giá trị description từ Map
    );
  }

  // 3️⃣ Chuyển Object Weather thành Map (Dùng khi cần gửi dữ liệu lên server hoặc lưu trữ cục bộ)
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'main': main,
      'description': description,
    };
  }

  // 4️⃣ Chuyển Object Weather thành chuỗi JSON (Dùng khi muốn lưu trữ hoặc gửi API)
  String toJson() => json.encode(toMap());
}

class Main {
  num temp;
  num feels_like;
  num temp_min;
  num temp_max;
  num humidity;
  Main({
    required this.temp,
    required this.feels_like,
    required this.temp_min,
    required this.temp_max,
    required this.humidity,
  });

  Map<String, dynamic> toMap() {
    // map trong flutter dung de luu
    return <String, dynamic>{
      'temp': temp,
      'feels_like': feels_like,
      'temp_min': temp_min,
      'temp_max': temp_max,
      'humidity': humidity,
    };
  }

  factory Main.fromMap(Map<String, dynamic> map) {
    // chuyen map thanh object de su dung trong flutter
    return Main(
      temp: map['temp'] as num,
      feels_like: map['feels_like'] as num,
      temp_min: map['temp_min'] as num,
      temp_max: map['temp_max'] as num,
      humidity: map['humidity'] as num,
    );
  }

  String toJson() => json.encode(
      toMap()); // chuyen object thanh chuoi json dung de luu tru hoac gui api

  factory Main.fromJson(String source) => Main.fromMap(json.decode(source)
      as Map<String, dynamic>); // chuyen doi json tu api sang map
}

class Wind {
  num speed;
  num deg;
  Wind({
    required this.speed,
    required this.deg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'speed': speed,
      'deg': deg,
    };
  }

  factory Wind.fromMap(Map<String, dynamic> map) {
    return Wind(
      speed: map['speed'] as num,
      deg: map['deg'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory Wind.fromJson(String source) =>
      Wind.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WeatherData {
  int id;
  List<Weather> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  String name;
  int cod;
  WeatherData({
    required this.id,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.name,
    required this.cod,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'weather': weather.map((x) => x.toMap()).toList(),
      'base': base,
      'main': main.toMap(),
      'visibity': visibility,
      'wind': wind.toMap(),
      'name': name,
      'cod': cod,
    };
  }

  factory WeatherData.fromMap(Map<String, dynamic> map) {
    return WeatherData(
      id: map['id'] != null ? map['id'] as int : 0, // Nếu null thì gán mặc định
      weather: List<Weather>.from(
        (map['weather'] as List?)?.map<Weather>(
              (x) => Weather.fromMap(x as Map<String, dynamic>),
            ) ??
            [],
      ),
      base: map['base'] ?? '', // Tránh lỗi nếu 'base' null
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
      visibility: map['visibility'] != null
          ? map['visibility'] as int
          : 0, // Sửa đúng tên field
      wind: Wind.fromMap(map['wind'] as Map<String, dynamic>),
      name: map['name'] ?? '',
      cod: map['cod'] != null ? map['cod'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherData.fromJson(String source) =>
      WeatherData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WeatherDetail {
  Main main;
  Weather weather;
  String dt_txt;
  WeatherDetail({
    required this.main,
    required this.weather,
    required this.dt_txt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'main': main.toMap(),
      'weather': weather.toMap(),
      'dt_txt': dt_txt,
    };
  }

  factory WeatherDetail.fromMap(Map<String, dynamic> map) {
    return WeatherDetail(
      main: Main.fromMap(map['main'] as Map<String, dynamic>),
      weather: Weather.fromMap(map['weather'][0] as Map<String, dynamic>),
      dt_txt: map['dt_txt'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherDetail.fromJson(String source) =>
      WeatherDetail.fromMap(json.decode(source) as Map<String, dynamic>);
}
