import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:audio_book_app/widgets/commons/course.dart';

class BookShelf extends StatefulWidget {
  @override
  _BookShelfState createState() => _BookShelfState();
}

class _BookShelfState extends State<BookShelf> {
  List<Course> courses = [
    Course.fromJSON({
      'chapterLabel': 'Chapter 15',
      'bookName': 'One Day',
      'termName': '第1期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020081311083151.jpeg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 41',
      'bookName': '你当像鸟飞往你的山',
      'termName': '第2期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020060517233085.jpeg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 7',
      'bookName': '第十二夜',
      'termName': '第3期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020051117451690.jpg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '弗兰肯斯坦',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/202004281128356.jpeg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '地心游记',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020053010221776.jpg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '木偶奇遇记',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020052018223837.jpg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '小熊维尼',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/202005121114535.jpg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '查泰莱夫人的情人',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020050714114531.jpeg',
      'isDone': false
    }),
    Course.fromJSON({
      'chapterLabel': 'Chapter 22',
      'bookName': '天方夜谭',
      'termName': '第4期',
      'cover': 'https://ali.baicizhan.com/readin/images/2020042811282241.png',
      'isDone': false
    }),
  ];
  bool modalVisible = false;
  List selectKind = [true, false, false];
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
                                    onTap: (){
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
                                onTap: (){
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                modalVisible = true;
                              });
                            },
                            child: Row(
                              children: [
                                Text(selectKind[0] ? '按完成状态' : selectKind[1] ? '按难度级别' : '按书单期数', style: TextStyle(color: Color(0xFF00B4AA), fontWeight: FontWeight.w500)),
                                SizedBox(width: 7),
                                Image.asset('images/icon_toDown.png', width: 10, height: 8)
                              ],
                            ),
                          )
                        ],
                      )
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
