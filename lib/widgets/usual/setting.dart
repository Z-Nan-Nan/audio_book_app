import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audio_book_app/net/api.dart';

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
                    )
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () async{
                List<Cookie> cookies = [];
                (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
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
