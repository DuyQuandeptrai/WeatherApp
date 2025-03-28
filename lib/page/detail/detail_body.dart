import 'package:appweather/apps/utils/asset.dart';
import 'package:appweather/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.listdata});

  final List<WeatherDetail> listdata;

  @override
  Widget build(BuildContext context) {
    return listdata.isEmpty
        ? Center(
            child: Text(
              "Không có dữ liệu dự báo",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: listdata.length > 7
                ? 7
                : listdata.length, // Giới hạn 10 phần tử
            itemBuilder: (context, index) {
              DateTime dateTime = DateTime.parse(listdata[index].dt_txt);
              String formatDay = DateFormat('EEEE').format(dateTime);
              String formatTime = DateFormat('HH:mm').format(dateTime);

              return Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color.fromARGB(148, 221, 221, 221),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "${listdata[index].main.temp}°C",
                                style: TextStyle(
                                    fontSize: 22, color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              Text(
                                listdata[index].weather.main,
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            formatDay,
                            style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 7, 97, 254),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            formatTime,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 4,
                      child: Image.asset(
                        AssetCustom.getlinkImg(listdata[index].weather.main),
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              );
            },
            separatorBuilder: (context, _) => SizedBox(height: 15),
          );
  }
}
