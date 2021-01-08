import 'package:flutter/material.dart';
import 'package:audio_book_app/tools/MyUnderlineIndecator.dart';
import 'dart:async';
import 'CommentList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'CountStar.dart';

class CourseDetail extends StatefulWidget {
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  List _courseTab = ['小王子', '纳尼亚传奇', '黑骏马', '傲慢与偏见'];
  List<String> tagData = ['最佳中篇奖', '追授“雨果奖”最佳中篇', '浅荷年度最佳中篇', '浅荷2020年最受欢迎书单'];
  int audioTime = 60;
  bool isPlay = false;
  double finish = 0;
  double unFinish = 130;
  Timer _timer;

  TabController _tabController;
  @protected
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _tabController = null;
    _tabController = TabController(
        initialIndex: 0, length: 4, vsync: this);

    print("---->${_tabController.previousIndex}");
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFFFFF)),
          child: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: 2,color: Color(0xFF00B4AA))),
            labelColor: Color(0xFF00B4AA),
            tabs: _courseTab.map((value) {
              return Center(
                  child: new Text(value)
              );
            }).toList(),
            unselectedLabelColor: Color(0xFF282828),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height:415,
          color: Color(0xFFFFFF),
          child: Stack(
            children: [
              TabBarView(
                controller: _tabController,
                children: _courseTab.map((item) {
                  return SingleChildScrollView(
                      child: Container(
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        padding: EdgeInsets.only(left: 28, right: 21),
                        color: Color(0xFFFFFF),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Container(
                              height: 135,
                              padding: EdgeInsets.only(left: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.01),
                              width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 88,
                                    height: 132,
                                    color: Colors.yellowAccent,
                                  ),
                                  SizedBox(width: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.03),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('小王子', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 6),
                                      Container(
                                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.16,
                                        child: Text('[法]安东尼·德·圣-埃克苏佩里/1942年出版/1942年出版1942年出版', style: TextStyle(fontSize: 12, color: Color(0xFF646464))),
                                      ),
                                      SizedBox(height: 11),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: BoxDecoration(color: Color(0xFF00C600), borderRadius: BorderRadius.all(Radius.circular(2))),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text('豆', style: TextStyle(color: Colors.white, fontSize: 8))
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 2),
                                          CountStar(star: 4.5, starColor: 'gold')
                                        ],
                                      ),
                                      SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('浅荷精编', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w600))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text('简介', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600),),
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Container(
                                  width: 325,
                                  child: Text('作者以小王子的孩子式的眼光，透视出成人的空虚、盲目，愚妄和死板教条，用浅显天真的语言写出了人类的孤独寂寞、没有根基随风流浪的命运。同时，也表达出作者对金钱关系的批判，对真善美的讴歌。', style: TextStyle(color: Color(0xFF282828), fontSize: 14),),
                                )
                              ],
                            ),
                            SizedBox(height: 14),
                            Container(
                              width: 325,
                              child: Wrap(
                                children: tagData.map((item) {
                                  return Container(
                                    height: 30,
                                    margin: EdgeInsets.only(top: 3, bottom: 3, right: 12),
                                    padding: EdgeInsets.only(left: 6, top: 5, right: 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Color(0xFFF0F0F0)),
                                    ),
                                    child: Text(item, style: TextStyle(fontSize: 12),),
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: 40),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Text('试听音频', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF282828)),),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Container(
                                          child: Text('美式发音', style: TextStyle(fontSize: 12, color: Color(0xFFA0A0A0), fontWeight: FontWeight.w400),),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(width: 30),
                                Container(
                                  width: 230,
                                  height: 44,
                                  padding: EdgeInsets.only(left: 13, top: 3),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(22)),
                                      color: Color(0xFFBADFDA)
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 500),
                                          child: isPlay ? Image.asset('images/icon_pause.png', width: 25, height: 25) : Image.asset('images/icon_play.png', width: 25, height: 25),
                                        ),
                                        onTap: (){
                                          setState(() {
                                            isPlay = !isPlay;
                                          });
                                          if (isPlay && unFinish != 0) {
                                            double process = unFinish / audioTime;
                                            const timeout = const Duration(seconds: 1);
                                            _timer = Timer.periodic(timeout, (timer) {
                                              setState(() {
                                                finish = finish + process;
                                                unFinish = unFinish - process;
                                              });
                                              if (unFinish < process) {
                                                process = unFinish;
                                                print('1');
                                              }
                                              print(unFinish);
                                            });
                                          } else {
                                            setState(() {
                                              if (_timer != null) {
                                                _timer.cancel();
                                                _timer = null;
                                              }
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(width: 14),
                                      Container(
                                        height: 2,
                                        width: finish,
                                        color: Colors.black26,
                                      ),
                                      Container(
                                        height: 2,
                                        width: unFinish,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 15),
                                      Text('${audioTime}s', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 14),)
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 40),
                            Container(
                              width: 375,
                              color: Color(0xFFFFFF),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommentList()
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  );
                }).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}

