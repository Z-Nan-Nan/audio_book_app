import 'package:flutter/material.dart';

import 'GradePicker.dart';
import 'RecommendReading.dart';

class RecommendTab extends StatefulWidget {
  RecommendTab({Key key}) : super(key: key);

  @override
  _RecommendTabState createState() => _RecommendTabState();
}

class _RecommendTabState extends State<RecommendTab> {

  List<Widget> _optionsList = [
    RecommendReading(),
    GradePicker()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 375,
              child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.white,
                      automaticallyImplyLeading: false,
                      bottom: PreferredSize(
                        preferredSize: Size(double.infinity, 0.0),
                        child: Material(
                          color: Colors.white,
                          child: TabBar(
                            isScrollable: true,
                            indicatorColor: Colors.white,
                            labelColor: Colors.black,
                            unselectedLabelColor: Colors.grey,
                            labelStyle: TextStyle(
                                fontSize: 20
                            ),
                            tabs: [
                              Tab(
                                text: '推荐阅读',
                              ),
                              Tab(
                                text: '薄荷课程',
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: _optionsList,
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

