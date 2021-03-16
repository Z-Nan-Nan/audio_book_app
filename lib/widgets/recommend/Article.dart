import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'ArticleComment.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/widgets/commons/commentVector.dart';

class Article extends StatefulWidget {
  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  List<dynamic> Passages = [];
  String title = '';
  int like = 0;
  String newComment = '';
  int readNum = 0;
  bool isLike = false;
  bool isHot = true;
  bool showBottomBar = true;
  double fixHeight = 0;
  bool heightIsSet = false;
  List <dynamic> commentList = [];
  GlobalKey controlKey = new GlobalKey();
  ScrollController _controller = new ScrollController();
  bool textFieldVisible = false;
  @override
  void initState() {
    void getArticleDetail() async {
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      for (var i in cookies) {
        if (i.name == 'article') {
          var result = await HttpUtils.request(
              '/get_article_detail',
              method: HttpUtils.POST,
              data: {
                'p_id': i.value,
                'r_id': cookies[0].value
              }
          );
          var res = DataTransfer.fromJSON(result);
          setState(() {
            Passages = res.data['article']['content'];
            title = res.data['article']['title'];
            like = res.data['article']['like'];
            isLike = res.data['is_like'];
            readNum = res.data['article']['read_num'];
            var arr = [];
            for (var i in res.data['article']['comment']) {
              if (i['top']) {
                arr.add(CommentVector.fromJSON(i));
              }
            }
            for (var i in res.data['article']['comment']) {
              if (!i['top']) {
                arr.add(CommentVector.fromJSON(i));
              }
            }
            commentList = arr;
          });
        }
      }
    }
    getArticleDetail();
    super.initState();
    _controller.addListener(() {
      RenderBox box = controlKey.currentContext.findRenderObject();
      Offset offset = box.localToGlobal(Offset.zero);
      print(offset.dy);
      if (_controller.offset > offset.dy * 2) {
        setState(() {
          showBottomBar = false;
        });
      } else {
        setState(() {
          showBottomBar = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                  height: 150,
                  decoration: BoxDecoration(color: Colors.white),
                  padding: EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(color: Color(0xFF282828), fontSize: 24, fontWeight: FontWeight.w700)),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('浅荷阅读', style: TextStyle(color: Color(0xFF00B4AA)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('更多话题', style: TextStyle(color: Color(0xFFA0A0A0))),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: 20.0,
                                color: Color(0xFF505050),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: Passages.map((item){
                      return Image.network(item, width: ScreenUtil().setWidth(ScreenUtil.screenWidth));
                    }).toList(),
                  ),
                ),
                Container(
                  key: controlKey,
                  width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if (isLike) {
                                      like = like - 1;
                                    } else {
                                      like = like + 1;
                                    }
                                    isLike = !isLike;
                                  });
                                },
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(boxShadow: [BoxShadow(color: Color(0xff282828), blurRadius: 2)],borderRadius: BorderRadius.all(Radius.circular(45)), color: isLike ? Color(0xFF00B4AA) : Colors.white, border: Border.all(color: Color(0xFF00B4AA), width: 1)),
                                  child: Center(
                                    child: Image.asset(isLike ? 'images/icon_clap_big.png' : 'images/action_clap_white.png', width: 52, height: 52),
                                  ),
                                ),
                              ),
                              SizedBox(height: 6),
                              Text('${like}次', style: TextStyle(color: Color(0xFF646464)))
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text('阅读 ${readNum}', style: TextStyle(color: Color(0xFF646464)))
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset('images/icon_share.png', width: 30, height: 30),
                              SizedBox(width: 2),
                              Text('分享', style: TextStyle(color: Color(0xFF646464), fontSize: 12)),
                              SizedBox(width: 20)
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                            decoration: BoxDecoration(color: Color(0xFFF0F0F0)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(width: 20),
                                    Text('精选留言', style: TextStyle(color: Color(0xFF646464))),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isHot = true;
                                        });
                                      },
                                      child: Text('最热', style: TextStyle(color: isHot ? Color(0xFF646464) : Color(0xFFA0A0A0), fontSize: 14, fontWeight: isHot ? FontWeight.w600 : FontWeight.w400)),
                                    ),
                                    Container(
                                      height: 14,
                                      child: VerticalDivider(
                                        width: 21,
                                        thickness: 2,
                                        color: Color(0xFFDCDCDC),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          isHot = false;
                                        });
                                      },
                                      child: Text('最新', style: TextStyle(color: !isHot ? Color(0xFF646464) : Color(0xFFA0A0A0), fontSize: 14, fontWeight: !isHot ? FontWeight.w600 : FontWeight.w400)),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(ScreenUtil.screenWidth - 1040),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          textFieldVisible = true;
                                        });
                                      },
                                      child: Image.asset('images/icon_pen.png', width: 30, height: 30),
                                    ),
                                    SizedBox(width: 2),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          textFieldVisible = true;
                                        });
                                      },
                                      child: Text('写留言', style: TextStyle(color: Color(0xFF00B4AA), fontSize: 12, fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20),
                                ArticleComment(commentList: commentList, setKind: isHot,)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
            bottom: 0,
            child: Offstage(
              offstage: !showBottomBar,
              child: Container(
                width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                height: 70,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Color(0xff282828), blurRadius: 10)]),
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if (isLike) {
                            like = like - 1;
                          } else {
                            like = like + 1;
                          }
                          isLike = !isLike;
                        });
                      },
                      child: Row(
                        children: [
                          Container(
                            child: Image.asset(isLike ? 'images/action_clap_green.png' : 'images/action_clap_white.png', width: 26, height: 26),
                          ),
                          SizedBox(width: 2),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: 23),
                              Text('${like}', style: TextStyle(color: Color(0xFF646464)))
                            ],
                          ),],
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(ScreenUtil.screenWidth - 1010),
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      radius: 0.0,
                      onTap: (){
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/icon_share.png', width: 30, height: 30),
                          SizedBox(width: 2),
                          Text('分享', style: TextStyle(color: Color(0xFF646464), fontSize: 12))
                        ],
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          textFieldVisible = true;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/icon_pen.png', width: 30, height: 30),
                          SizedBox(width: 2),
                          Text('留言', style: TextStyle(color: Color(0xFF646464), fontSize: 12))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Offstage(
              offstage: !textFieldVisible,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    textFieldVisible = false;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                },
                child: Container(
                  width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                  height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
                  decoration: BoxDecoration(color: Color(0x99000000)),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Offstage(
              offstage: !textFieldVisible,
              child: Container(
                width: ScreenUtil().setWidth(ScreenUtil.screenWidth - 795),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              textFieldVisible = false;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                          child: Image.asset('images/icon_delete.png', width: 30, height: 30),
                        ),
                        Text('       写留言', style: TextStyle(color: Color(0xFF282828), fontSize: 18, fontWeight: FontWeight.w600)),
                        GestureDetector(
                          onTap: () async{
                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                            var articleId = '';
                            for (var i in cookies) {
                              if (i.name == 'article') {
                                articleId = i.value;
                              }
                            }
                            var result = await HttpUtils.request(
                              '/send_new_comment',
                              method: 'post',
                              data: {
                                'r_id': cookies[0].value,
                                'p_id': articleId,
                                'comment': newComment
                              }
                            );
                            var res = DataTransfer.fromJSON(result);
                            if (res.status == 1) {
                              setState(() {
                                textFieldVisible = false;
                              });
                            }
                          },
                          child: Container(
                            width: 68,
                            height: 30,
                            decoration: BoxDecoration(color: Color(0xFF00B4AA), borderRadius: BorderRadius.all(Radius.circular(28))),
                            child: Center(child: Text('提交', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
                          ),
                        )
                      ],
                    ),
                    TextField(
                      onChanged: (val){
                        setState((){
                          newComment = val;
                        });
                      },
                      maxLines: 8,
                      showCursor: true,
                      cursorWidth: 3,
                      cursorRadius: Radius.circular(10),
                      cursorColor: Color(0xFF00B4AA),
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.unspecified,
                      style: TextStyle(
                        color: Color(0xFF646464),
                        letterSpacing: 1
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
