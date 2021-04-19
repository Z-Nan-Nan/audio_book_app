import 'package:flutter/material.dart';
import 'ReadingTag.dart';
import 'package:audio_book_app/net/api.dart';
import 'dart:io';

class PGCTags extends StatefulWidget {
  PGCTags({Key key, this.pId, this.sTag, this.title, this.subTitle, this.like, this.cover}):super(key: key);
  final String pId;
  final String sTag;
  final String title;
  final String subTitle;
  final int like;
  final String cover;
  @override
  _PGCTagsState createState() => _PGCTagsState();
}

class _PGCTagsState extends State<PGCTags> {
  @override
  Widget build(BuildContext context) {
    if (widget.sTag == '浅荷话题') {
      return GestureDetector(
        onTap: () async{
          List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
          cookies.add(new Cookie('article', widget.pId));
          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
          Navigator.pushNamed(context, '/article');
        },
        child: Container(
          width: 335,
          height: 243,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(widget.cover), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Color(0x26000000),offset: Offset(0.0, 15.0), blurRadius: 15.0, spreadRadius: 1.0)]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReadingTag(words: widget.sTag),
              SizedBox(height: 26),
              Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 24 )),
              SizedBox(height: 6),
              Text(widget.subTitle, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12)),
              SizedBox(height: 61),
              Text('${widget.like}人喜欢', style: TextStyle(color: Colors.white, fontSize: 12))
            ],
          ),
        ),
      );
    } else if (widget.sTag == 'Mint News') {
      return GestureDetector(
        onTap: ()async{
          List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
          cookies.add(new Cookie('article', widget.pId));
          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
          Navigator.pushNamed(context, '/article');
        },
        child: Container(
          width: 335,
          height: 156,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Color(0x26000000),offset: Offset(0.0, 15.0), blurRadius: 15.0, spreadRadius: 1.0)]
          ),
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 68,
                    height: 20,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(2), color: Color(0xFFF0F0F0)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('${widget.sTag}', style: TextStyle(color: Color(0xFF646464), fontSize: 12))
                      ],
                    ),
                  ),
                  SizedBox(height: 13),
                  Text(widget.title, style: TextStyle(color: Color(0xFF282828), fontSize: 16)),
                  SizedBox(height: 12),
                  Text(widget.subTitle, style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),),
                  SizedBox(height: 20),
                  Text('${widget.like}人喜欢', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12))
                ],
              ),
              SizedBox(width: 40),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 98,
                    height: 98,
                    decoration: BoxDecoration(color: Color(0xFFD8D8D8), borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: NetworkImage(widget.cover), fit: BoxFit.cover)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: ()async{
          List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
          cookies.add(new Cookie('article', widget.pId));
          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
          Navigator.pushNamed(context, '/article');
        },
        child: Container(
          width: 335,
          height: 240,
          decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: Color(0x26000000),offset: Offset(0.0, 15.0), blurRadius: 15.0, spreadRadius: 1.0)]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 335,
                height: 145,
                padding: EdgeInsets.only(left: 15, top: 14, bottom: 111, right: 262),
                decoration: BoxDecoration(
                    image: DecorationImage(image: NetworkImage(widget.cover), fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(10), topLeft: Radius.circular(10))
                ),
                child: ReadingTag(words: widget.sTag),
              ),
              Container(
                width: 335,
                height: 95,
                padding: EdgeInsets.only(top: 9, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: TextStyle(fontSize: 16, color: Color(0xFF282828))),
                    SizedBox(height: 5),
                    Text(widget.subTitle, style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                    SizedBox(height: 12),
                    Text('${widget.like}人喜欢', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),)
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
