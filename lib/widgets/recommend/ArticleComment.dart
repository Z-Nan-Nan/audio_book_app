import 'package:flutter/material.dart';
import 'CommentData_test.dart';

// ignore: must_be_immutable
class ArticleComment extends StatefulWidget {
  ArticleComment({Key key, this.commentList, this.setKind}) : super(key:key);
  final List commentList;
  bool setKind;
  @override
  _ArticleCommentState createState() => _ArticleCommentState();
}

class _ArticleCommentState extends State<ArticleComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: widget.commentList.map((item){
          if (widget.setKind) {
            if (item.kind == 'hot') {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(item.authorInfo['avatar']), fit: BoxFit.cover,)),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(item.authorInfo['nickname'], style: TextStyle(color: Color(0xFF646464))),
                              SizedBox(width: 9),
                              Offstage(
                                offstage: !item.top,
                                child: Container(
                                  width: 36,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xBBDCDCDC),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: Text('置顶', style: TextStyle(color: Color(0xFF646464), fontSize: 12)),
                                  ),
                                ),
                              )
                            ],
                          )
                          // Image.asset('images/star.png', width: 11, height: 11)
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${item.like}', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                              SizedBox(width: 2),
                              GestureDetector(
                                child: item.isLike ? Image.asset('images/isLike.png', width: 17, height: 19,) : Image.asset('images/unlike.png', width: 17, height: 19),
                                onTap: (){
                                  setState(() {
                                    item.isLike = !item.isLike;
                                    if (item.isLike) {
                                      item.like++;
                                    } else {
                                      item.like--;
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 52),
                      Container(
                        width: 274,
                        child: Text(item.content, style: TextStyle(color: Color(0xFF282828), height: 2),),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              );
            } else {
              return Container();
            }
          } else {
            if (item.kind == 'new') {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), image: DecorationImage(image: NetworkImage(item.authorInfo['avatar']), fit: BoxFit.cover,)),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(item.authorInfo['nickname'], style: TextStyle(color: Color(0xFF646464))),
                              SizedBox(width: 9),
                              Offstage(
                                offstage: !item.top,
                                child: Container(
                                  width: 36,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Color(0xBBDCDCDC),
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  child: Center(
                                    child: Text('置顶', style: TextStyle(color: Color(0xFF646464), fontSize: 12)),
                                  ),
                                ),
                              )
                            ],
                          )
                          // Image.asset('images/star.png', width: 11, height: 11)
                        ],
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${item.like}', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                              SizedBox(width: 2),
                              GestureDetector(
                                child: item.isLike ? Image.asset('images/isLike.png', width: 17, height: 19,) : Image.asset('images/unlike.png', width: 17, height: 19),
                                onTap: (){
                                  setState(() {
                                    item.isLike = !item.isLike;
                                    if (item.isLike) {
                                      item.like++;
                                    } else {
                                      item.like--;
                                    }
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 52),
                      Container(
                        width: 274,
                        child: Text(item.content, style: TextStyle(color: Color(0xFF282828), height: 2),),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                ],
              );
            } else {
              return Container();
            }
          }
        }).toList(),
      ),
    );
  }
}
