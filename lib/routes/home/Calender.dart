import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:audio_book_app/tools/DayStatus.dart';
import 'package:audio_book_app/widgets/commons/month.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  ScrollController controller = new ScrollController();
  List <DayStatus> daysList = [];
  bool modalVisible = false;
  var renderObject = {};
  int readTypeOne = 0;
  int readTypeTwo = 0;
  int readTypeThree = 0;
  @override
  void initState() {
    void getRenderInfo(id) async{
      var result = await HttpUtils.request(
        '/get_calender_info?r_id=$id',
        method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        renderObject = res.data;
        for (var i in res.data['days_list']) {
          for (var j in i['days']) {
            if (j['read'] == 1) {
              readTypeOne++;
            }
            if (j['read'] == 2) {
              readTypeTwo++;
            }
            if (j['read'] == 3) {
              readTypeThree++;
            }
          }
          daysList.add(DayStatus.fromJSON(i));
        }
      });
    }
    void getCookie() async {
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      getRenderInfo(cookies[0].value);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var nowTime = DateTime.now();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 164, bottom: 200),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),

              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 78, left: 18, right: 18, bottom: 9),
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Day ${renderObject['day_num'] < 10 ? '0' : ''}${renderObject['day_num']}', style: TextStyle(color: Color(0xFF282828), fontSize: 22, fontWeight: FontWeight.w600, fontFamily: 'NewYork')),
                        Container(
                          width: 208,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('正读 $readTypeOne', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                              SizedBox(width: 14),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFFFFD3AF), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('补读 $readTypeTwo', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                              SizedBox(width: 14),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFFF0F0F0), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('未完成 $readTypeThree', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 27),
                    Container(
                      width: 320,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('一', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('二', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('三', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('四', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('五', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('六', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('日', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(height: 9),
                    // Month(year: daysList[0].year, nowMonth: month1, pos: 0,),
                    Container(
                      width: 375,
                      height: 400,
                      child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Month(year: daysList[0].year, nowMonth: daysList[0].startMonth, pos: 0, daysMap: daysList[0].days, startDay: daysList[0].startDay),
                              Month(year: daysList[1].year, nowMonth: daysList[1].startMonth, pos: 1, daysMap: daysList[1].days, startDay: daysList[1].startDay),
                              Month(year: daysList[2].year, nowMonth: daysList[2].startMonth, pos: 2, daysMap: daysList[2].days, startDay: daysList[2].startDay),
                              SizedBox(height: 80)
                            ],
                          )
                      ),
                    )
                    // Month(year: daysList[0].year, nowMonth: month3, pos: 2)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  width: 339,
                  height: 188,
                  padding: EdgeInsets.only(top: 18, bottom: 18, left: 18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x26000000),offset: Offset(0.0, 18.0), blurRadius: 36.0, spreadRadius: 1.0)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('${renderObject['book_group']['name']}', style: TextStyle(color: Color(0xFF01B4AB), fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        height: 116,
                        width: 323,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Book(height: 115, coverUrl: '${renderObject['book_group_info'][0]['img_src']}'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: '${renderObject['book_group_info'][1]['img_src']}'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: '${renderObject['book_group_info'][2]['img_src']}'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: '${renderObject['book_group_info'][3]['img_src']}'),
                              SizedBox(width: 14),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
