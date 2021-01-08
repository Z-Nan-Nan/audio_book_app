import 'package:flutter/material.dart';
import 'dart:async';
import 'CommentList.dart';
import 'package:audio_book_app/widgets/recommend/CourseDetail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseInfo extends StatefulWidget {
  @override
  _CourseInfoState createState() => _CourseInfoState();
}

class _CourseInfoState extends State<CourseInfo> {

  ScrollController _scrollController;

  TabController _tabController;

  GlobalKey tooltipKey = new GlobalKey();
  double firstDy = 0.0;
  bool firstVisible = false;
  List<String> tagData = ['最佳中篇奖', '追授“雨果奖”最佳中篇', '薄荷年度最佳中篇', '薄荷2020年最受欢迎书单'];
  int audioTime = 60;
  bool isPlay = false;
  double finish = 0;
  double unFinish = 130;
  Timer _timer;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
        color: Color(0xFFFFFF),
        child: Stack(
          children: [
            InkWell(
              highlightColor: Colors.transparent,
              radius: 0.0,
              onTap: (){
                setState(() {
                  firstVisible = false;
                });
              },
              child: Container(
                height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
                child: SingleChildScrollView(
                  physics: firstVisible ? new NeverScrollableScrollPhysics() : null,
                  child: Column(
                    children: [
                      Image.asset('images/course_top.png', width: ScreenUtil().setWidth(ScreenUtil.screenWidth)),
                      Container(
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.03, top: 10, bottom: 10, right: 27),
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        height: 44,
                        color: Color(0xFFF0F0F0),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 7, top: 2, bottom: 2, right: 6),
                              width: 62,
                              height: 26,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  border: Border.all(width: 1, color: Color(0xFFDCDCDC))
                              ),
                              child: Text('第77期', style: TextStyle(color: Color(0xFF646464), fontSize: 14),),
                            ),
                            SizedBox(width: 14),
                            Text('开课：03月06日 - 结课：09月06日', style: TextStyle(color: Color(0xFF646464), fontSize: 14),)
                          ],
                        ),
                      ),
                      Container(
                        height: 88,
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.05, top: 21, bottom: 18),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('经典级', style: TextStyle(color: Color(0xFF282828), fontSize: 18)),
                                SizedBox(height: 6),
                                Text('级别', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12))
                              ],
                            ),
                            SizedBox(width: 63),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('4500以上', style: TextStyle(color: Color(0xFF282828), fontSize: 18)),
                                SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text('词汇要求', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                                    SizedBox(width: 9),
                                    Container(
                                      padding: EdgeInsets.only(left: 4, top: 1, bottom: 1),
                                      width: 48,
                                      height: 21,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                          border: Border.all(width: 1, color: Color(0xFFDCDCDC))
                                      ),
                                      child: Text('不匹配', style: TextStyle(color: Color(0xFFE02020), fontSize: 12),),
                                    ),
                                    SizedBox(width: 7),
                                    InkWell(
                                      key: tooltipKey,
                                      child: Container(
                                        width: 16,
                                        height: 16,
                                        padding: EdgeInsets.only(left: 4),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(8)),
                                            color: Color(0xFFDCDCDC).withOpacity(0.5)
                                        ),
                                        child: Text('?', style: TextStyle(color: Color(0xFF646464)),),
                                      ),
                                      onTap: (){
                                        RenderBox box = tooltipKey.currentContext.findRenderObject();
                                        Offset offset = box.localToGlobal(Offset.zero);
                                        setState(() {
                                          firstDy = offset.dy + 28.0;
                                          firstVisible = true;
                                        });
                                      },
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        indent: 20,
                        endIndent: 20,
                      ),
                      Container(
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        height: 100,
                        padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.pink),
                            ),
                            SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Bill', style: TextStyle(color: Color(0xFF282828), fontSize: 16),),
                                    SizedBox(width: 6),
                                    Container(
                                      width: 74,
                                      height: 23,
                                      padding: EdgeInsets.only(left: 7, top: 3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        color: Color(0xFF0C6ED2).withOpacity(0.15),
                                      ),
                                      child: Text('书单主理人', style: TextStyle(color: Color(0xFF282828), fontSize: 12, fontWeight: FontWeight.w600),),
                                    )
                                  ],
                                ),
                                SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text('北京大学 语言学博士', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),)
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        height: 120,
                        padding: EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            VerticalDivider(),
                            SizedBox(width: 12),
                            Container(
                              width: 320,
                              height: 120,
                              child: Text('《小王子（中英文对照本）》是2001年哈尔滨出版社出版的图书，作者是法国安东·德·圣艾修伯里。小说讲述了一个因飞机失事而滞留而滞留而，小说讲述了一个因飞机失事而滞留而滞留而小说讲述了一个因飞机失事而滞留而滞留而小说讲述了一个因飞机失事而滞留而滞留而小说讲述了一个。',
                                style: TextStyle(color: Color(0xFF282828), fontSize: 14),),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: 355,
                        height: 56,
                        padding: EdgeInsets.only(left: 30, top: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color(0xFFF0F0F0).withOpacity(0.5)
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.blue),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text('内容策划', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                                SizedBox(height: 3),
                                Text('JeffersonJeffers', style: TextStyle(color: Color(0xFF282828), fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            ),
                            SizedBox(width: 22),
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.yellow),
                            ),
                            SizedBox(width: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5),
                                Text('讲义编辑', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                                SizedBox(height: 3),
                                Text('Jefferson', style: TextStyle(color: Color(0xFF282828), fontSize: 14, fontWeight: FontWeight.w600),)
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      // Expanded(
                      //   child: SizedBox(
                      //     height: 200,
                      //     child: NestedScrollView(
                      //       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                      //         return <Widget> [
                      //           SliverAppBar(
                      //             expandedHeight: 230.0,
                      //             pinned: true,
                      //             flexibleSpace: Padding(
                      //               padding: EdgeInsets.symmetric(vertical: 8),
                      //               child: PageView(),
                      //             ),
                      //           ),
                      //           SliverPersistentHeader(
                      //             pinned: true,
                      //             delegate: StickyTabBarDelegate(
                      //               child: TabBar(
                      //                 labelColor: Colors.black,
                      //                 controller: this._tabController,
                      //                 tabs: <Widget>[
                      //                   Tab(text: '资讯'),
                      //                   Tab(text: '技术'),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ];
                      //       },
                      //       body: TabBarView(
                      //         controller: this._tabController,
                      //         children: <Widget>[
                      //           Container(
                      //             height: 50,
                      //           ),
                      //           Container(
                      //             height: 100,
                      //           )
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // )
                      SizedBox(
                        height: 470,
                        child: CourseDetail(),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                        padding: EdgeInsets.only(top: 20, left: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.02, bottom: 20),
                        color: Color(0xFFF0F0F0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('浏览过「环球梦工厂」的读者也会读', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600),),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('images/bookPic_1.png', width: 78, height: 120),
                                    SizedBox(height: 8),
                                    Text('心理学百科', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600, fontSize: 12),),
                                    SizedBox(height: 3),
                                    Text('成长/真善美', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 10))
                                  ],
                                ),
                                SizedBox(width: 46),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('images/bookPic_1.png', width: 78, height: 120),
                                    SizedBox(height: 8),
                                    Text('心理学百科', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600, fontSize: 12),),
                                    SizedBox(height: 3),
                                    Text('成长/真善美', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 10))
                                  ],
                                ),
                                SizedBox(width: 46),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('images/bookPic_1.png', width: 78, height: 120),
                                    SizedBox(height: 8),
                                    Text('心理学百科', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600, fontSize: 12),),
                                    SizedBox(height: 3),
                                    Text('成长/真善美', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 10))
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 60)
                          ],
                        ),
                      ),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 90,
                padding: EdgeInsets.only(top: 10, left: 67, right: 21, bottom: 30),
                color: Colors.white,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('￥358', style: TextStyle(color: Color(0xFFFF6E0A), fontSize: 20),)
                          ],
                        ),
                        Text('原价￥458', style: TextStyle(decoration: TextDecoration.lineThrough, color: Color(0xFFA0A0A0), fontSize: 12),),
                      ],
                    ),
                    SizedBox(width: 20),
                    Row(
                      children: [
                        OutlineButton(
                          color: Color(0xFFFFFF),
                          borderSide: BorderSide(color: Color(0xFF00B4AA),width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28))
                          ),
                          child: Text('加入购物袋', style: TextStyle(color: Color(0xFF00B4AA), fontSize: 14),),
                          onPressed: (){
                          },
                        )
                      ],
                    ),
                    SizedBox(width: 14),
                    Row(
                      children: [
                        FlatButton(
                          minWidth: 106,
                          height: 40,
                          color: Color(0xFF00B4AA),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(28))
                          ),
                          child: Text('立即购买', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),),
                          onPressed: (){
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: firstDy,
              left: 212,
              child: Offstage(
                offstage: !firstVisible,
                child: Container(
                  width: 142,
                  height: 96,
                  padding: EdgeInsets.only(left: 11, top: 7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: Offset(0.0, 10.0),
                            blurRadius: 20
                        )
                      ]
                  ),
                  child: Text('文案不超过五十个字哦文案不超过五十个字哦文案不超过五十个字哦文案不超过五十个字哦文案不超过五十个字哦', style: TextStyle(color: Color(0xFF646464), fontSize: 12),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
