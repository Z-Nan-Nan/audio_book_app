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
        '/get_note_info?r_id=$id',
        method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
      print(result);
      for (var i in result.data) {
        for (var j in i['notes']) {
          setState(() {
            count++;
          });
        }
      }
      setState(() {
        renderObject = result.data;
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
            SizedBox(height: 18)
          ],
        ),
      ),
    );
  }
}
