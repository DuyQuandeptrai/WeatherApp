import 'package:appweather/page/detail/detail_page.dart';
import 'package:appweather/page/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomCustom extends StatefulWidget {
  const BottomCustom({super.key});

  @override
  State<BottomCustom> createState() => _BottomCustomState();
}

class _BottomCustomState extends State<BottomCustom> {
  int activePage = 0;

  final List<Widget> listPages = [
    HomePage(),
    DetailPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: activePage,
        children: listPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: activePage,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        onTap: (index) {
          setState(() {
            activePage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.list_bullet),
            label: 'List',
          ),
        ],
      ),
    );
  }
}
