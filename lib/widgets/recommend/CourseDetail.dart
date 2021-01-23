import 'package:flutter/material.dart';
import 'package:audio_book_app/tools/MyUnderlineIndecator.dart';
import 'dart:async';
import 'CommentList.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'CountStar.dart';

class CourseDetail extends StatefulWidget {
  CourseDetail({Key key, this.renderDetail}): super (key:key);
  var renderDetail = [];
  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {

  List _courseTab = [];
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
    print(widget.renderDetail);
    for (var item in widget.renderDetail) {
      if (item['rate'] is int) {
        item['rate'] = double.parse(item['rate'].toString());
      }
      setState(() {
        _courseTab.add(item);
      });
    }
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
                  child: new Text(value['name_cn'])
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
                        padding: EdgeInsets.only(left: 26, right: 21),
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
                                  Book(height: 132, coverUrl: '${item['img_src']}'),
                                  SizedBox(width: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.03),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${item['name_cn']}', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 6),
                                      Container(
                                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.16,
                                        child: Text('${item['author']}', style: TextStyle(fontSize: 12, color: Color(0xFF646464))),
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
                                          CountStar(star: item['rate'], starColor: 'gold')
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
                                  child: Text('${item['book_desc']}', style: TextStyle(color: Color(0xFF282828), fontSize: 14),),
                                )
                              ],
                            ),
                            SizedBox(height: 14),
                            Container(
                              width: 325,
                              child: Wrap(
                                children: item['tags'].map<Widget>((item) {
                                  return Container(
                                    height: 30,
                                    margin: EdgeInsets.only(top: 3, bottom: 3, right: 12),
                                    padding: EdgeInsets.only(left: 6, top: 5, right: 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 2, color: Color(0xFFF0F0F0)),
                                    ),
                                    child: Text('${item}', style: TextStyle(fontSize: 12),),
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
                                  CommentList(list: item['hot_comments'])
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

