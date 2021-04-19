import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

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
      return GestureDetector(
        onTap: ()async{
          List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
          var res = await HttpUtils.request(
              '/api_calender_book_info?r_id=${cookies[0].value}&need_date=2021/${widget.nowMonth}/${widget.date}',
              method: HttpUtils.GET
          );
          var ret = DataTransfer.fromJSON(res);
          var flag = true;
          for (var i in cookies) {
            if (i.name == 'select_book') {
              i.value = ret.data['bookId'];
              flag = false;
            }
          }
          if (flag) {
            print('yes');
            cookies.add(new Cookie('select_book', ret.data['bookId']));
          }
          var flag2 = true;
          for (var i in cookies) {
            if (i.name == 'select_article') {
              i.value = ret.data['day'].toString();
              flag2 = false;
            }
          }
          if (flag2) {
            print('yes');
            cookies.add(new Cookie('select_article', ret.data['day'].toString()));
          }
          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
          Navigator.pushNamed(context, '/audioBook');
        },
        child: Container(
          width: 33,
          height: 33,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: Colors.white, boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
          child: Center(
            child: Text('今', style: TextStyle(color: Color(0xFF01B4AB), fontSize: 14, fontWeight: FontWeight.w600)),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: ()async{
          List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
          var res = await HttpUtils.request(
            '/api_calender_book_info?r_id=${cookies[0].value}&need_date=2021/${widget.nowMonth}/${widget.date}',
            method: HttpUtils.GET
          );
          var ret = DataTransfer.fromJSON(res);
          var flag = true;
          for (var i in cookies) {
            if (i.name == 'select_book') {
              i.value = ret.data['bookId'];
              flag = false;
            }
          }
          if (flag) {
            print('yes');
            cookies.add(new Cookie('select_book', ret.data['bookId']));
          }
          var flag2 = true;
          for (var i in cookies) {
            if (i.name == 'select_article') {
              i.value = ret.data['day'].toString();
              flag2 = false;
            }
          }
          if (flag2) {
            print('yes');
            cookies.add(new Cookie('select_article', ret.data['day'].toString()));
          }
          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
          Navigator.pushNamed(context, '/audioBook');
        },
        child: Container(
          width: 33,
          height: 33,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(17), color: bgColor),
          child: Center(
            child: Text('${widget.date}', style: TextStyle(color: fontColor, fontSize: 14)),
          ),
        ),
      );
    }
  }
}
