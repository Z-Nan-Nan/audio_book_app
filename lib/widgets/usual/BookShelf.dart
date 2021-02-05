import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:audio_book_app/widgets/commons/course.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf> {
  List<Course> courses = [];
  bool modalVisible = false;
  List selectKind = [true, false, false];
  @override
  void initState() {
    void getRenderInfo(cookie) async {
      var result = await HttpUtils.request(
        '/get_user_bookshelf_info?r_id=${cookie}',
        method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        for (var item in res.data) {
          print(item);
          courses.add(Course.fromJSON(item));
        }
      });
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      getRenderInfo(cookies[0].value);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
            padding: EdgeInsets.only(left: 20, right: 20, top: 70),
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                    padding: EdgeInsets.only(top: 80, bottom: 50),
                    child: Wrap(
                      children: courses.map((course){
                        return Container(
                          width: 175,
                          height: 300,
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Book(height: 196, coverUrl: course.cover),
                                  GestureDetector(
                                    onTap: ()async{
                                      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                      var flag = true;
                                      for (var i in cookies) {
                                        if (i.name == 'select_book') {
                                          i.value = course.bookId;
                                          flag = false;
                                        }
                                      }
                                      if (flag) {
                                        print('yes');
                                        cookies.add(new Cookie('select_book', course.bookId));
                                      }
                                      (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                      Navigator.pushNamed(context, '/audioBook');
                                    },
                                    child: Container(
                                      height: 196,
                                      width: 145,
                                      color: Colors.transparent,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 15),
                              Text('${course.bookName}', style: TextStyle(color: Color(0xFF646464))),
                              SizedBox(height: 6),
                              GestureDetector(
                                onTap: ()async{
                                  List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                  bool flag = true;
                                  for (var item in cookies) {
                                    if (item.name == 'share_book_id') {
                                      item.value = course.bookId;
                                      flag = false;
                                    }
                                  }
                                  if (flag) {
                                    cookies.add(new Cookie('share_book_id', course.bookId));
                                  }
                                  (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                  Navigator.pushNamed(context, '/readingResult');
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('阅读数据', style: TextStyle(color: Color(0xFF00B4AA), fontWeight: FontWeight.w500)),
                                    SizedBox(width: 6),
                                    Image.asset('images/icon_arrow_right.png', width: 5, height: 7)
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('images/bookshelf_word.png', width: 61, height: 30)
                        ],
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       onTap: (){
                      //         setState(() {
                      //           modalVisible = true;
                      //         });
                      //       },
                      //       child: Row(
                      //         children: [
                      //           Text(selectKind[0] ? '按完成状态' : selectKind[1] ? '按难度级别' : '按书单期数', style: TextStyle(color: Color(0xFF00B4AA), fontWeight: FontWeight.w500)),
                      //           SizedBox(width: 7),
                      //           Image.asset('images/icon_toDown.png', width: 10, height: 8)
                      //         ],
                      //       ),
                      //     )
                      //   ],
                      // )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 355,
                    padding: EdgeInsets.only(left: 20, top: 14, bottom: 30, right: 20),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            Color(0xFFFFFFFF),
                            Color(0x00FFFFFF),
                          ],
                        )
                    ),
                    child: GestureDetector(
                      onTap: (){
                      },
                      child: Container(
                        width: 80,
                        height: 36,
                        decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(31))),
                        child: Center(
                          child: Text('分享你的阅读成果', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              setState(() {
                modalVisible = false;
              });
            },
            child: Offstage(
              offstage: !modalVisible,
              child: Stack(
                children: [
                  Container(
                    width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                    height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
                    decoration: BoxDecoration(color: Color(0x99000000)),
                  ),
                  Positioned(
                    top: 105,
                    left: 174,
                    child: Container(
                      width: 200,
                      height: 171,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                selectKind = [true, false, false];
                                modalVisible = false;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 46,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('按完成状态', style: TextStyle(color: selectKind[0] ? Color(0xFF00B4AA) : Color(0xFF282828), fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                selectKind = [false, true, false];
                                modalVisible = false;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 46,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('按难度级别', style: TextStyle(color: selectKind[1] ? Color(0xFF00B4AA) : Color(0xFF282828), fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                          Divider(),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                selectKind = [false, false, true];
                                modalVisible = false;
                              });
                            },
                            child: Container(
                              width: 200,
                              height: 46,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('按书单期数', style: TextStyle(color: selectKind[2] ? Color(0xFF00B4AA) : Color(0xFF282828), fontSize: 16))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
