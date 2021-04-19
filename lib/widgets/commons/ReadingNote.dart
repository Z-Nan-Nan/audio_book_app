import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';
class ReadingNote extends StatefulWidget {
  @override
  _ReadingNoteState createState() => _ReadingNoteState();
}

class _ReadingNoteState extends State<ReadingNote> {
  var renderObject = [];
  int count = 0;
  @override
  void initState(){
    void getRenderInfo(id) async{
      var res = await HttpUtils.request(
        '/api_get_note_info?r_id=$id',
        method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
      print(result);
      for (var i in result.data) {
        setState(() {
          count++;
        });
      }
      setState(() {
        renderObject = result.data;
      });
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
      getRenderInfo(cookies[0].value);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.symmetric(vertical: 48, horizontal: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('阅读笔记', style: TextStyle(color: Color(0xFF282828), fontSize: 29, fontWeight: FontWeight.w600)),
                Text('共$count条', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600))
              ],
            ),
            SizedBox(height: 13),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('笔记', style: TextStyle(color: Color(0xFF00B4AA), fontSize: 14, fontWeight: FontWeight.w600)),
                SizedBox(height: 6),
                Container(width: 20, height: 2, decoration: BoxDecoration(color: Color(0xFF00B4AA)))
              ],
            ),
            SizedBox(height: 18),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: renderObject.map((item) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${item['date'].split('/')[0]}.${item['date'].split('/')[1]}.${item['date'].split('/')[2]}', style: TextStyle(color: Color(0xFF282828), fontFamily: 'NewYork', fontStyle: FontStyle.italic, fontSize: 16)),
                      SizedBox(height: 9),
                      Text('${item['content']}', style: TextStyle(color: Color(0xFF282828))),
                      SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 2,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF646464)
                            ),
                          ),
                          SizedBox(width: 17),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${item['sentence']}', style: TextStyle(color: Color(0xFF646464), fontSize: 13)),
                                SizedBox(height: 12),
                                Text('${item['name_cn']}Chapter${item['day']}', style: TextStyle(fontSize: 13, color: Color(0x88282828)))
                              ],
                            ),
                          )
                        ],
                      ),
                      Divider()
                    ],
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
