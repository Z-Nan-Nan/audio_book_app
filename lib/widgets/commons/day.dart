import 'package:flutter/material.dart';

class Day extends StatefulWidget {
  Day({Key key, this.date, this.status, this.nowMonth}):super(key:key);
  final int date;
  final int status;
  final int nowMonth;
  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  @override
  Widget build(BuildContext context) {
    var nowDay = DateTime.now();
    Color bgColor;
    Color fontColor;
    switch(widget.status) {
      case 0:
        bgColor = Color(0xFFFFFFFF);
        fontColor = Color(0xFFDCDCDC);
        break;
      case 1:
        bgColor = Color(0xFF01B4AB);
        fontColor = Color(0xFFFFFFFF);
        break;
      case 2:
        bgColor = Color(0xFFFFD3AF);
        fontColor = Color(0xFF282828);
        break;
      case 3:
        bgColor = Color(0xFFF0F0F0);
        fontColor = Color(0xFF282828);
        break;
    }
    if (widget.date == 0) {
      return Container(
        width: 33,
        height: 33,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17)),
      );
    } else if (widget.date == nowDay.day && widget.nowMonth == nowDay.month) {
      return Container(
        width: 33,
        height: 33,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Colors.white, boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
        child: Center(
          child: Text('今', style: TextStyle(color: Color(0xFF01B4AB), fontSize: 14, fontWeight: FontWeight.w600)),
        ),
      );
    } else {
      return Container(
        width: 33,
        height: 33,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: bgColor),
        child: Center(
          child: Text('${widget.date}', style: TextStyle(color: fontColor, fontSize: 14)),
        ),
      );
    }
  }
}
