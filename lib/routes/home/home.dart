import 'package:audio_book_app/routes/home/Achievement.dart';
import 'package:audio_book_app/routes/home/Calender.dart';
import 'package:audio_book_app/routes/home/Recommend.dart';
import 'package:audio_book_app/routes/home/Today.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<Widget> tabPanels = [
    Today(),
    Calender(),
    Recommend(),
    Achievement()
  ];

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBuilder: (BuildContext context, int index) {
        return widget.tabPanels[index];
      },
      tabBar: CupertinoTabBar(
        currentIndex: _currentIndex,
        iconSize: 20.0,
        activeColor: Theme.of(context).primaryColor,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '今日阅读'),
          BottomNavigationBarItem(icon: Icon(Icons.date_range), label: '计划'),
          BottomNavigationBarItem(icon: Icon(Icons.view_day), label: '推荐'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: '我的')
        ],
      ),
    );
  }
}
