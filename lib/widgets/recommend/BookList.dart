import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/widgets/recommend/ListData_test.dart';

import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class BookList extends StatefulWidget {
  final ValueChanged<int> countCallBack;
  BookList ({Key key, this.countCallBack}):super(key:key);

  @override

  _BookListState createState() => _BookListState();
}


class ThemeColors {
  static Color colorShopping = Color(0xFF00B4AA);
}

class MyCustomPainter extends CustomPainter {
  Paint _paint = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    // print('size:$size');
    canvas.drawRRect(
        RRect.fromLTRBR(0, 0, size.width, size.height, Radius.circular(10)), _paint);
  }

  @override
  bool shouldRepaint(MyCustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}

class _BookListState extends State<BookList> {
  List <Books> booksList = [];
  int vocCount = 0;
  sendShoppingCartInfo(id, buy) async {
    List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
    var result = await HttpUtils.request(
        '/post_shoppingcart_info',
        method: HttpUtils.POST,
        data: {
          'rId': cookies[0].value,
          'groupId': id,
          'buy': buy
        }
    );
    var res = DataTransfer.fromJSON(result);
    if (res.status == 1) {
      print('操作成功');
    }
  }
  @override
  void initState() {
    void getGroupList(cookie) async {
      var result = await HttpUtils.request(
          '/get_book_grouplist',
          method: HttpUtils.POST,
          data: {
            'r_id': cookie.value
          }
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        vocCount = res.data['voc_count'];
        for (var i in res.data['list']) {
          print(i);
          booksList.add(Books.fromJSON(i));
        }
      });
      var count = 0;
      for (var i in booksList) {
        if (i.buy) {
          count++;
        }
      }
      widget.countCallBack(count);
    }
    void getCookie() async {
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      getGroupList(cookies[0]);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 90,
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              SizedBox(height: 25),
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                      backgroundColor: Colors.brown,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text('你的词汇量：${vocCount}', style: TextStyle(color: Color(0xFF646464), fontSize: 14))
                ],
              )
            ],
          ),
        ),
        Column(
          children: booksList.map((item){
            return GestureDetector(
              onTap: ()async{
                List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                bool flag = true;
                for (var i in cookies) {
                  if (i.name == 'is_visit_book_group') {
                    flag = false;
                    i.value = item.groupId;
                  }
                }
                if (flag) {
                  cookies.add(new Cookie('is_visit_book_group', item.groupId));
                  (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                }
                Navigator.pushNamed(context, '/courseInfo');
              },
              child: Column(
                children: [
                  Container(
                    width: 347,
                    height: 305,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        Offstage(
                          offstage: !item.recommend,
                          child: Row(
                            children: [
                              SizedBox(width: 20),
                              Image.asset('images/icon_royal.png', width: 30.0, height: 23.0,),
                              Text('为你推荐', style: TextStyle(color: Color(0xFF646464)))
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 10),
                                Text(item.title, style: TextStyle(color: Color(0xFF282828), fontSize: 20)),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FlatButton(
                                  height: 32,
                                  minWidth: 100,
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide.none,
                                      borderRadius: BorderRadius.all(Radius.circular(32))
                                  ),
                                  child: Text(
                                      item.buy ? '已加入' :'加入购书袋',
                                      style: TextStyle(color: Colors.white, fontSize: 14)),
                                  color: item.buy ? Color(0xFF99E1DD) : Color(0xFF00B4AA),
                                  onPressed: () {
                                    var num = 0;
                                    item.buy = !item.buy;
                                    if (item.buy) {
                                      item.pay = true;
                                    }
                                    booksList.map((item){
                                      if (item.buy) {
                                        num++;
                                      }
                                    }).toList();
                                    widget.countCallBack(num);
                                    sendShoppingCartInfo(item.groupId, item.buy);
                                  },
                                ),
                                SizedBox(width: 10)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 18),
                            Text(item.tag, style: TextStyle(color: Color(0xFF282828), fontSize: 12))
                          ],
                        ),
                        Divider(
                          indent: 20,
                          endIndent: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: 20),
                                Container(
                                  width: 170,
                                  height: 170,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text('书单目录',style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: item.lists.map((i){
                                          return Text(i['name_cn'], style: TextStyle(color: Color(0xFF282828), fontSize: 14));
                                        }).toList(),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        width: 90,
                                        height: 30,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(12)),
                                            color: Color(0xFFF0F0F0)
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                                backgroundImage: NetworkImage(item.avatar)
                                            ),
                                            SizedBox(width: 2),
                                            Text('书单主理人： ${item.manager}', style: TextStyle(color: Color(0xFF282828), fontSize: 12),)
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Image.network(item.images, width: 108, height: 165)
                                    // Container(
                                    //   height: 165,
                                    //   width: 108,
                                    //   child: CustomPaint(
                                    //     painter: MyCustomPainter(),
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(width: 10)
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              ),
            );
          }).toList(),
        ),
        Container(
          height: 48,
          width: 335,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Color(0xFFFFFFFF)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: 16),
                  Text('到底啦，告诉薄荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.arrow_forward_ios_outlined),
                  SizedBox(width: 16)
                ],
              )
            ],
          ),
        ),
        SizedBox(height: 100)
      ],
    );
  }
}
