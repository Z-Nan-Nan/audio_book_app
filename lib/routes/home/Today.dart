import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_book_app/widgets/commons/course.dart';
import 'package:audio_book_app/widgets/today/activityCourse.dart';
import 'package:audio_book_app/widgets/usual/login.dart';
import 'package:audio_book_app/widgets/commons/DailyPictures.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';
class Today extends StatefulWidget {
  @override
  _TodayState createState() => _TodayState();
}

class _TodayState extends State<Today> {
  bool isMintFinished = true;
  List<Course> courses = [];
  int rightQuestion = 0;
  int week = 0;

  @override
  void initState() {
    void test() async {
      var res = await HttpUtils.request(
          '/api_get_audio_book_data',
          method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
    }
    // test();
    void getUserInfo(cookies) async {
      print(cookies[0].value);
      var result = await HttpUtils.request(
          '/api_get_user_today_info',
          method: HttpUtils.POST,
          data: {
            'rId': cookies[0].value
          }
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        rightQuestion = res.data['course_info']['count'];
        week = res.data['course_info']['week'];
      });
      for (var i in res.data['books_info']) {
        var obj = {
          'chapterLabel': 'Chapter ${i['is_chapter']}',
          'bookName': i['name_cn'],
          'termName': '第${i['term']}期',
          'cover': i['img_src'],
          'isDone': i['is_done']
        };
        setState(() {
          courses.add(Course.fromJSON(obj));
        });
      }
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
      if (cookies.length == 0) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => route == null);
      } else {
        getUserInfo(cookies);
      }
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    print(courses);
    return Scaffold(
      body: Container(
        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
        height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DailyPictures(),
              SizedBox(height: 25),
              Container(
                width: 344,
                height: 78,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                decoration: BoxDecoration(color: Color(0xFFF1F1F1), borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    isMintFinished ? Image.asset('images/goldenmint_finish.png', width: 36, height: 36) : Image.asset('images/goldCoin.png', width: 36, height: 36),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('第${week}周', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12, letterSpacing: 4)),
                        SizedBox(height: 4),
                        Text('课后题正确数 ${rightQuestion}/21', style: TextStyle(color: Color(0xFF505050), fontSize: 16, fontWeight: FontWeight.w500))
                      ],
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/goldenMint');
                      },
                      child: Image.asset('images/arrow_circle_right.png', width: 20, height: 20),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: ActivityCourses(courses: courses),
              )
            ],
          ),
        ),
      )
    );
  }
}

