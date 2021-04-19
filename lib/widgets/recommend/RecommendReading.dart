import 'package:flutter/material.dart';
import 'package:audio_book_app/tools/MyUnderlineIndecator.dart';
import 'ReadingTag.dart';
import 'PGCTags.dart';
import 'package:audio_book_app/widgets/commons/pgc.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class RecommendReading extends StatefulWidget {
  @override
  _RecommendReadingState createState() => _RecommendReadingState();
}

class _RecommendReadingState extends State<RecommendReading> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  List _readingTab = ['全部', '书单故事', '看见TA们', 'Mint News', '浅荷话题'];
  List <Pgc> pgcList = [];
  List <Pgc> pgc1 = [];
  List <Pgc> pgc2 = [];
  List <Pgc> pgc3 = [];
  List <Pgc> pgc4 = [];
  TabController _tabController;
  @protected
  bool get wantKeepAlive => true;
  @override
  void initState() {
    void getPGCList() async {
      var result = await HttpUtils.request(
          '/api_get_pgc_list',
          method: HttpUtils.GET,
          data: {}
      );
      var res = DataTransfer.fromJSON(result);
      print(res.data);
      setState(() {
        for (var i in res.data['pgc_list']) {
          pgcList.add(Pgc.fromJSON(i));
          if (i['tag'] == '书单故事') {
            pgc1.add(Pgc.fromJSON(i));
          }
          if (i['tag'] == '看见TA们') {
            pgc2.add(Pgc.fromJSON(i));
          }
          if (i['tag'] == 'Mint News') {
            pgc3.add(Pgc.fromJSON(i));
          }
          if (i['tag'] == '浅荷话题') {
            pgc4.add(Pgc.fromJSON(i));
          }
        }
      });
    }
    getPGCList();
    _tabController = null;
    _tabController = TabController(
        initialIndex: 0, length: 5, vsync: this); // 直接传this
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white),
            alignment: Alignment.centerLeft,
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: MyUnderlineTabIndicator(borderSide: BorderSide(width: 2,color: Color(0xFF00B4AA))),
              labelColor: Color(0xFF00B4AA),
              tabs: _readingTab.map((value) {
                return Center(
                  child: new Text(value),
                );
              }).toList(),
              unselectedLabelColor: Color(0xFF282828),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: _readingTab.map((value) {
                if (value == '全部') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pgcList.map((item) {
                              return Column(
                                children: [
                                  PGCTags(
                                    sTag: item.sTag,
                                    title: item.title,
                                    subTitle: item.subTitle,
                                    like: item.like,
                                    cover: item.cover,
                                    pId: item.pId,
                                  ),
                                  SizedBox(height: 30)
                                ],
                              );
                            }).toList()
                        ),
                        SizedBox(height: 20),
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
                                  Text('到底啦，告诉浅荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
                    ),
                  );
                } else if (value == '书单故事') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pgc1.map((item) {
                              return Column(
                                children: [
                                  PGCTags(
                                    sTag: item.sTag,
                                    title: item.title,
                                    subTitle: item.subTitle,
                                    like: item.like,
                                    cover: item.cover,
                                    pId: item.pId,
                                  ),
                                  SizedBox(height: 30)
                                ],
                              );
                            }).toList()
                        ),
                        SizedBox(height: 20),
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
                                  Text('到底啦，告诉浅荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
                    ),
                  );
                } else if (value == '看见TA们') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pgc2.map((item) {
                              return Column(
                                children: [
                                  PGCTags(
                                    sTag: item.sTag,
                                    title: item.title,
                                    subTitle: item.subTitle,
                                    like: item.like,
                                    cover: item.cover,
                                    pId: item.pId,
                                  ),
                                  SizedBox(height: 30)
                                ],
                              );
                            }).toList()
                        ),
                        SizedBox(height: 20),
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
                                  Text('到底啦，告诉浅荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
                    ),
                  );
                } else if (value == 'Mint News') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pgc3.map((item) {
                              return Column(
                                children: [
                                  PGCTags(
                                    sTag: item.sTag,
                                    title: item.title,
                                    subTitle: item.subTitle,
                                    like: item.like,
                                    cover: item.cover,
                                    pId: item.pId,
                                  ),
                                  SizedBox(height: 30)
                                ],
                              );
                            }).toList()
                        ),
                        SizedBox(height: 20),
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
                                  Text('到底啦，告诉浅荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
                    ),
                  );
                } else if (value == '浅荷话题') {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: pgc4.map((item) {
                              return Column(
                                children: [
                                  PGCTags(
                                    sTag: item.sTag,
                                    title: item.title,
                                    subTitle: item.subTitle,
                                    like: item.like,
                                    cover: item.cover,
                                    pId: item.pId,
                                  ),
                                  SizedBox(height: 30)
                                ],
                              );
                            }).toList()
                        ),
                        SizedBox(height: 20),
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
                                  Text('到底啦，告诉浅荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
                    ),
                  );
                }
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

