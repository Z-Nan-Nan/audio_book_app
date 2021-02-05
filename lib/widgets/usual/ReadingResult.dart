import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class ReadingResult extends StatefulWidget {
  @override
  _ReadingResultState createState() => _ReadingResultState();
}

class ReadPercent {
  final String name;
  final int num;
  final charts.Color color;

  ReadPercent(this.name, this.num, Color color)
      : this.color = new charts.Color(
      r: color.red, g: color.green, b: color.blue, a: color.alpha);
}

class _ReadingResultState extends State<ReadingResult> {
  bool isEditAble = false;
  String commentWord = '太棒了，恭喜你完成人生中的第一本英文书！太棒了，恭喜你完成人生中的第一本英文书！';
  int starCount = 1;
  var renderObject = {};
  final controller = TextEditingController();
  // var data = [
  //   // new ReadPercent('补读', 12, Color(0xFFFFD3AF)),
  //   // new ReadPercent('正读', 42, Color(0xFF01B4AB))
  // ];
  List<ReadPercent> data = [];
  @override
  void initState() {
    void getRenderInfo(info, book) async{
      var result = await HttpUtils.request(
        '/get_share_book_info?r_id=$info&book_id=$book',
        method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        renderObject = res.data;
        // print((renderObject['find_book']['finish_state']['fix_read'] is int));
        data.add(new ReadPercent('补读', renderObject['find_book']['finish_state']['fix_read'], Color(0xFFFFD3AF)));
        data.add(new ReadPercent('正读', renderObject['find_book']['finish_state']['is_read'], Color(0xFF01B4AB)));
      });
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      for (var item in cookies) {
        if (item.name == 'share_book_id') {
          getRenderInfo(cookies[0].value, item.value);
        }
      }
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    var series = [
      new charts.Series(
        domainFn: (ReadPercent clickData, _) => clickData.name,
        measureFn: (ReadPercent clickData, _) => clickData.num,
        colorFn: (ReadPercent clickData, _) => clickData.color,
        id: 'Clicks',
        data: data,
      ),
    ];
    var chart = new charts.PieChart(
      series,
      animate: true,
    );
    var chartWidget = new Padding(
      padding: new EdgeInsets.all(32.0),
      child: new SizedBox(
        height: 200.0,
        child: chart,
      ),
    );
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
            color: Color(0xFF282828),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Color(0xFF282828)])),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 274,
                      decoration: BoxDecoration(color: Colors.black, image: DecorationImage(image: AssetImage('images/bgLight.png'), fit: BoxFit.cover,)),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 73),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Book(height: 238, coverUrl: '${renderObject['book_detail']['img_src']}')
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 28),
                              height: MediaQuery.of(context).size.height - 315,
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('${renderObject['book_detail']['name_cn']}', style: TextStyle(color: Colors.white, fontSize: 25))
                                      ],
                                    ),
                                    SizedBox(height: 9),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('第${renderObject['book_detail']['term']}期', style: TextStyle(color: Colors.white))
                                      ],
                                    ),
                                    SizedBox(height: 9),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('共${renderObject['book_detail']['chapter_num'].length}章，${renderObject['book_detail']['words']}字', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11))
                                      ],
                                    ),
                                    SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: ()async{
                                            setState(() {
                                              starCount = 1;
                                            });
                                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                            bool flag = true;
                                            for (var item in cookies) {
                                              if (item.name == 'share_book_rate') {
                                                item.value = '1';
                                                flag = false;
                                              }
                                            }
                                            if (flag) {
                                              cookies.add(new Cookie('share_book_rate', '1'));
                                            }
                                            (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                          },
                                          child: Image.asset('images/star_white.png', width: 18, height: 18),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                            onTap: ()async{
                                              setState(() {
                                                starCount = 2;
                                              });
                                              List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                              bool flag = true;
                                              for (var item in cookies) {
                                                if (item.name == 'share_book_rate') {
                                                  item.value = '2';
                                                  flag = false;
                                                }
                                              }
                                              if (flag) {
                                                cookies.add(new Cookie('share_book_rate', '2'));
                                              }
                                              (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                            },
                                          child: starCount >= 2 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                            onTap: ()async{
                                              setState(() {
                                                starCount = 3;
                                              });
                                              List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                              bool flag = true;
                                              for (var item in cookies) {
                                                if (item.name == 'share_book_rate') {
                                                  item.value = '3';
                                                  flag = false;
                                                }
                                              }
                                              if (flag) {
                                                cookies.add(new Cookie('share_book_rate', '3'));
                                              }
                                              (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                            },
                                          child: starCount >= 3 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: ()async{
                                            setState(() {
                                              starCount = 4;
                                            });
                                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                            bool flag = true;
                                            for (var item in cookies) {
                                              if (item.name == 'share_book_rate') {
                                                item.value = '4';
                                                flag = false;
                                              }
                                            }
                                            if (flag) {
                                              cookies.add(new Cookie('share_book_rate', '4'));
                                            }
                                            (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                          },
                                          child: starCount >= 4 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: ()async{
                                            setState(() {
                                              starCount = 5;
                                            });
                                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                            bool flag = true;
                                            for (var item in cookies) {
                                              if (item.name == 'share_book_rate') {
                                                item.value = '5';
                                                flag = false;
                                              }
                                            }
                                            if (flag) {
                                              cookies.add(new Cookie('share_book_rate', '5'));
                                            }
                                            (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                          },
                                          child: starCount == 5 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                        ),
                                        SizedBox(width: 7),
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              isEditAble = true;
                                              controller.text = commentWord;
                                            });
                                          },
                                          child: Image.asset('images/icon_green_pen.png', width: 18, height: 18),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 18),
                                    isEditAble ?
                                    Container(
                                      width: 339,
                                      height: 169,
                                      decoration: BoxDecoration(color: Color(0xFF323232), borderRadius: BorderRadius.all(Radius.circular(9))),
                                      padding: EdgeInsets.only(top: 18, left: 18, right: 18),
                                      child: TextField(
                                        style: TextStyle(color: Colors.white),
                                        controller: controller,
                                        maxLines: 4,
                                        showCursor: true,
                                        cursorWidth: 3,
                                        cursorRadius: Radius.circular(10),
                                        cursorColor: Color(0xFF00B4AA),
                                        keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.unspecified,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: commentWord,
                                          hintStyle:TextStyle(color: Colors.white)
                                        ),
                                      ),
                                    ) :
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 18),
                                      child: Text('${commentWord}', style: TextStyle(color: Colors.white, fontSize: 13)),
                                    ),
                                    SizedBox(height: 54),
                                    Divider(color: Color(0xFF3C3C3C),indent: 18,endIndent: 18),
                                    Container(
                                      height: 75,
                                      width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                                      padding: EdgeInsets.symmetric(vertical: 26, horizontal: 18),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('阅读时长', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                          Text('${(renderObject['find_book']['reading_time'] / 3600).ceil()}小时${((renderObject['find_book']['reading_time'] / 60 - (renderObject['find_book']['reading_time'] / 3600).ceil()) / 60).ceil()}分钟', style: TextStyle(color: Colors.white, fontSize: 16))
                                        ],
                                      ),
                                    ),
                                    Divider(color: Color(0xFF3C3C3C),indent: 18,endIndent: 18),
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 27, horizontal: 18),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('完成情况', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                          SizedBox(height: 9),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 11,
                                                height: 11,
                                                decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(6))),
                                              ),
                                              SizedBox(width: 7),
                                              Text('正读', style: TextStyle(color: Colors.white)),
                                              SizedBox(width: 7),
                                              Text('${renderObject['find_book']['finish_state']['is_read']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                              Container(
                                                height: 15,
                                                child: VerticalDivider(
                                                  width: 50,
                                                  thickness: 1,
                                                  color: Color(0xFFF0F0F0),
                                                ),
                                              ),
                                              Container(
                                                width: 11,
                                                height: 11,
                                                decoration: BoxDecoration(color: Color(0xFFFFD3AF), borderRadius: BorderRadius.all(Radius.circular(6))),
                                              ),
                                              SizedBox(width: 7),
                                              Text('补读', style: TextStyle(color: Colors.white)),
                                              SizedBox(width: 7),
                                              Text('${renderObject['find_book']['finish_state']['fix_read']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                                            ],
                                          ),
                                          chartWidget
                                        ],
                                      ),
                                    ),
                                    Divider(color: Color(0xFF3C3C3C),indent: 18,endIndent: 18),
                                    Container(
                                      height: 109,
                                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 27),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('课后题正确率', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                              SizedBox(height: 9),
                                              Text('${((renderObject['find_book']['question_info']['right'] / (renderObject['find_book']['question_info']['right'] + renderObject['find_book']['question_info']['false'])) * 100).ceil()}%', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300))
                                            ],
                                          ),
                                          Container(
                                            height: 60,
                                            child: VerticalDivider(
                                              width: 5,
                                              thickness: 0.3,
                                              color: Color(0xFFF0F0F0),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              Text('连续正读天数', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                              SizedBox(height: 9),
                                              Text('${renderObject['find_book']['finish_state']['is_read_line']}天', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(color: Color(0xFF3C3C3C),indent: 18,endIndent: 18),
                                    SizedBox(height: 135)
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            child: Container(
              height: 46,
              padding: EdgeInsets.only(top: 13, left: 20, right: 18),
              child: GestureDetector(
                onTap: () async{
                  if(isEditAble) {
                    setState(() {
                      isEditAble = false;
                      commentWord = controller.text;
                    });
                    List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                    var result = await HttpUtils.request(
                        '/save_temp_data',
                        method: HttpUtils.POST,
                        data: {
                          'r_id': cookies[0].value,
                          'key': 'share_comment',
                          'value': commentWord
                        });
                  } else {
                    List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                    bool flag = true;
                    for (var item in cookies) {
                      if (item.name == 'share_book_rate') {
                        item.value = '$starCount';
                        flag = false;
                      }
                    }
                    if (flag) {
                      cookies.add(new Cookie('share_book_rate', '$starCount'));
                    }
                    (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                    var result = await HttpUtils.request(
                        '/save_temp_data',
                        method: HttpUtils.POST,
                        data: {
                          'r_id': cookies[0].value,
                          'key': 'share_comment',
                          'value': commentWord
                        });
                    Navigator.pushNamed(context, '/shareBook');
                  }
                },
                child: Container(
                  width: 339,
                  height: 33,
                  decoration: BoxDecoration(
                      color: Color(0xFF01B4AB),
                      borderRadius: BorderRadius.all(Radius.circular(28))
                  ),
                  child: Center(
                    child: Text(isEditAble ? '提交' : '分享你的阅读成果', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
