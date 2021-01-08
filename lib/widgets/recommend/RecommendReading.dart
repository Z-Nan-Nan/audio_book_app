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
  List _readingTab = ['全部', '书单推荐', '看见TA们', 'Mint News', '话题'];
  List <Pgc> pgcList = [];
  TabController _tabController;
  @protected
  bool get wantKeepAlive => true;
  @override
  void initState() {
    void getPGCList() async {
      var result = await HttpUtils.request(
          '/get_pgc_list',
          method: HttpUtils.GET,
          data: {}
      );
      var res = DataTransfer.fromJSON(result);
      print(res.data);
      setState(() {
        for (var i in res.data['pgc_list']) {
          print(i);
          pgcList.add(Pgc.fromJSON(i));
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
                          return PGCTags(
                            sTag: item.sTag,
                            title: item.title,
                            subTitle: item.subTitle,
                            like: item.like,
                            cover: item.cover,
                            aId: item.aId,
                          );
                        }).toList()
                          // InkWell(
                          //   highlightColor: Colors.transparent,
                          //   radius: 0.0,
                          //   onTap: (){
                          //     Navigator.pushNamed(context, '/article');
                          //   },
                          //   child: PGCTags(
                          //     sTag: '看见他们',
                          //     title: '薄荷专访赵又廷，你想听的都在这里',
                          //     subTitle: '我们共同完成首部明星英文有声书',
                          //     like: 1314,
                          //     color: Colors.lightGreenAccent,
                          //   ),
                          // ),
                          // SizedBox(height: 30),
                          // PGCTags(
                          //     sTag: 'Mint News',
                          //     title: '用户给送过的奇葩礼物',
                          //     subTitle: '带你探索故事最初的样子',
                          //     like: 1314
                          // ),
                          // SizedBox(height: 30),
                          // PGCTags(
                          //     sTag: '浅荷话题',
                          //     title: '真的有圣诞老人吗？',
                          //     subTitle: '又是一年圣诞，南方的冬日暖阳白花花，虽过不了白色圣诞节，过白日圣诞也是好的。',
                          //     like: 622
                          // ),
                          // SizedBox(height: 20),
                          // PGCTags(
                          //     sTag: '新书推荐',
                          //     title: '早晨来而复去，白昼却不曾降临',
                          //     subTitle: '吸血鬼缘何成为「偶像派」？',
                          //     like: 1314,
                          //     color: Colors.black26
                          // ),
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
                                Text('到底啦，告诉薄荷你还想看什么书', style: TextStyle(color: Color(0xFF282828), fontSize: 14),)
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
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

