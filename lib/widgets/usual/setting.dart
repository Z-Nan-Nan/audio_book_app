import 'dart:io';
import 'package:alarm_calendar/alarm_calendar_plugin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audio_book_app/net/api.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool openRoll = true;
  int hour = 6;
  int minute = 30;
  List memoryPosition = [];
  double hPosition = 0.0;
  double scrollPosition = 0.0;
  ScrollController controller = new ScrollController();
  double sPosition = 0.0;
  double scrollPosition1 = 0.0;
  ScrollController controller1 = new ScrollController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        scrollPosition = controller.offset;
      });
      const timeout = const Duration(seconds: 1);
      Timer(timeout, () {
        if (hPosition != 0.0 && hPosition != 23.0) {
          if (controller.offset < hPosition * 20) {
            if (hPosition * 20 - controller.offset < 10) {
              controller.animateTo(hPosition * 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            } else {
              controller.animateTo((hPosition - 1) * 20 - 2,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            }
          } else {
            if (controller.offset - hPosition * 20 < 10) {
              controller.animateTo(hPosition * 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            } else {
              controller.animateTo((hPosition + 1) * 20 + 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            }
          }
        }
      });
    });
    controller1.addListener(() {
      setState(() {
        scrollPosition1 = controller1.offset;
      });
      const timeout = const Duration(seconds: 1);
      Timer(timeout, () {
        if (sPosition != 0.0 && sPosition != 59.0) {
          if (controller1.offset < sPosition * 20) {
            if (sPosition * 20 - controller1.offset < 10) {
              controller1.animateTo(sPosition * 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            } else {
              controller1.animateTo((sPosition - 1) * 20 - 2,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            }
          } else {
            if (controller1.offset - sPosition * 20 < 10) {
              controller1.animateTo(sPosition * 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            } else {
              controller1.animateTo((sPosition + 1) * 20 + 20,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease
              );
            }
          }
        }
      });
    });
  }
  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(left: 18, right: 18, top: 74),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('阅读设置', style: TextStyle(color: Color(0xFF282828), fontSize: 22)),
                SizedBox(height: 37),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('阅读中开启单章循环播放', style: TextStyle(color: Color(0xFF282828))),
                    CupertinoSwitch(
                      value: openRoll,
                      activeColor: Color(0xFF00B4AA),
                      onChanged: (value){
                        setState(() {
                          openRoll = value;
                        });
                      },
                    )
                  ],
                ),
                SizedBox(height: 18),
                Divider(),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('阅读提醒设置', style: TextStyle(color: Color(0xFF282828))),
                    Container(
                      child: Row(
                        children: [
                          Container(
                              width: 72,
                              height: 25,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4)), border: Border.all(color: Color(0xFF00B4AA), width: 2)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      width: 26,
                                      height: 25,
                                      child: NotificationListener(
                                        onNotification: (ScrollNotification note){
                                          var position = note.metrics.pixels.toInt() / 20;
                                          setState(() {
                                            hPosition = position.roundToDouble();
                                          });
                                        },
                                        child: ListView.builder(
                                          itemCount: 24,
                                          controller: controller,
                                          cacheExtent: 1.0,
                                          padding: EdgeInsets.only(top: 0),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              height: 20,
                                              child: Center(
                                                child: Text('${index < 10 ? '0${index}' : index}', style: TextStyle(color: Color(0xFF282828), fontSize: 19)),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                  ),
                                  SizedBox(width: 2),
                                  Text(':', style: TextStyle(color: Color(0xFF282828), fontSize: 18)),
                                  SizedBox(width: 2),
                                  Container(
                                      width: 26,
                                      height: 25,
                                      child: NotificationListener(
                                        onNotification: (ScrollNotification note){
                                          var position = note.metrics.pixels.toInt() / 20;
                                          setState(() {
                                            sPosition = position.roundToDouble();
                                          });
                                        },
                                        child: ListView.builder(
                                          itemCount: 60,
                                          controller: controller1,
                                          cacheExtent: 1.0,
                                          padding: EdgeInsets.only(top: 0),
                                          itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                              height: 20,
                                              child: Center(
                                                child: Text('${index < 10 ? '0${index}' : index}', style: TextStyle(color: Color(0xFF282828), fontSize: 19)),
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                  ),
                                ],
                              )
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: ()async{
                              print(hPosition.round());
                              print(sPosition.round());
                              var h = hPosition.round();
                              var s = sPosition.round();
                              Calendars calendars = new Calendars(DateTime(2021,3,23,h,s),DateTime(2021,3,23,h,s),'浅荷阅读','读书时间到啦！',[0],'1',0);
                              List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
                              var res = await HttpUtils.request(
                                '/api_set_clock?r_id=${cookies[0].value}&eventId=0',
                                method: HttpUtils.GET
                              );
                              var result = DataTransfer.fromJSON(res);
                              if (result.status == 2) {
                                await AlarmCalendar.CheckReadPermission().then((res) async {
                                  if(res){
                                    //查询是否有写权限
                                    await AlarmCalendar.CheckWritePermission().then((resWrite) async{
                                      if(resWrite){
                                        final id = await AlarmCalendar.createEvent(calendars);
                                        calendars.setEventId = id;
                                        print('获得ID为：'+id);
                                        var res1 = await HttpUtils.request(
                                          '/api_set_clock?r_id=${cookies[0].value}&eventId=$id',
                                          method: HttpUtils.GET
                                        );
                                        var ret1 = DataTransfer.fromJSON(res1);
                                        if (ret1.status == 1) {
                                          print('ok');
                                        }
                                      }
                                    });
                                  }
                                });
                              } else {
                                AlarmCalendar.deleteEvent(result.data);
                                calendars.setEventId = '';
                                await AlarmCalendar.CheckWritePermission().then((resWrite) async{
                                  if(resWrite){
                                    final id = await AlarmCalendar.createEvent(calendars);
                                    calendars.setEventId = id;
                                    print('获得ID为：'+id);
                                    var res1 = await HttpUtils.request(
                                        '/api_set_clock?r_id=${cookies[0].value}&eventId=$id',
                                        method: HttpUtils.GET
                                    );
                                    var ret1 = DataTransfer.fromJSON(res1);
                                    if (ret1.status == 1) {
                                      print('ok');
                                    }
                                  }
                                });
                              }
                            },
                            child: Container(
                              width: 50,
                              height: 30,
                              decoration: BoxDecoration(color: Color(0xFF00B4AA), borderRadius: BorderRadius.all(Radius.circular(13))),
                              child: Center(
                                child: Text('确定', style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () async{
                List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
                for (var i in cookies) {
                  i.value = '';
                }
                (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
                Navigator.pushNamed(context, '/login');
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(color: Colors.redAccent),
                child: Center(
                  child: Text('退出登录', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
