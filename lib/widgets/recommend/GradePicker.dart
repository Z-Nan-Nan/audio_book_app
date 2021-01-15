import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BookList.dart';


class GradePicker extends StatefulWidget {
  GradePicker({Key key}) : super(key: key);
  @override

  // State<StatefulWidget> createState() {
  //   return new ParentWidgetState();
  // }

  _GradePickerState createState() => _GradePickerState();
}



class _GradePickerState extends State<GradePicker> {
  bool firstBtn = false;
  bool secondBtn = false;
  bool _showFirst = true;
  bool chooseVisible = false;
  String gradeSet = '全部级别';
  String kindSet = '全部分类';
  List gradeData = ['全部级别', '入门级(1500～3800)', '经典级(3800～6500)', '进阶级(6500～9500)', '高阶级(9500以上)'];
  List kindData = ['全部分类', '科幻', '成长', '悬疑', '环球梦工厂', '百科', '漫威世界', '心理学', '美丽人生', '女性成长', '奇幻', '家庭故事'];

  int count = 0;
  void changeCount(int num) {
    setState(() {
      count = num;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    print('设备宽度:${ScreenUtil.screenWidth}');
    print('设备高度:${ScreenUtil.screenHeight}');
    print('设备像素密度:${ScreenUtil.pixelRatio}');
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: ScreenUtil().setWidth(ScreenUtil.screenWidth) * 0.06),
        child: FloatingActionButton(
          child: Container(
            width: 54,
            height: 54,
            child: Stack(
              children: [
                Center(
                  child: Image.asset('images/shopping_bag.png', width: 32.0, height: 32.0,),
                ),
                Column(
                  children: [
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(11)),
                              color: Colors.red
                          ),
                          child: Center(
                            child: Text('${count}', style: TextStyle(fontSize: 16),),
                          ),
                        ),
                        SizedBox(width: 5),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          backgroundColor: Color(0xFFFFFFFF),
          onPressed: () {
            Navigator.pushNamed(context, '/shoppingBag');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
              color: Color(0xFFF0F0F0),
              child: BookList(countCallBack: changeCount),
            ),
          ),
          Container(
              height: ScreenUtil().setHeight(ScreenUtil.screenHeight),
              width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTapUp: (TapUpDetails tapUpDetails) {
                                  setState(() {
                                    firstBtn = !firstBtn;
                                    if (firstBtn == true) {
                                      secondBtn = false;
                                    }
                                    if (firstBtn == true || secondBtn == true) {
                                      chooseVisible = true;
                                    }
                                    if (firstBtn == false && secondBtn == false) {
                                      chooseVisible = false;
                                    }
                                    if (firstBtn == true && secondBtn == false) {
                                      _showFirst = true;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Text(gradeSet, style: TextStyle(fontSize: 16)),
                                    Icon(firstBtn ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              child: GestureDetector(
                                onTapUp: (TapUpDetails tapUpDetails) {
                                  setState(() {
                                    secondBtn = !secondBtn;
                                    if (secondBtn == true) {
                                      firstBtn = false;
                                    }
                                    if (firstBtn == true || secondBtn == true) {
                                      chooseVisible = true;
                                    }
                                    if (firstBtn == false && secondBtn == false) {
                                      chooseVisible = false;
                                    }
                                    if (firstBtn == false && secondBtn == true) {
                                      _showFirst = false;
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    Text(kindSet, style: TextStyle(fontSize: 16)),
                                    Icon(secondBtn ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Offstage(
                    offstage: !chooseVisible,
                    child: Column(
                      children: [
                        AnimatedCrossFade(
                          duration: Duration(seconds: 1),
                          crossFadeState:
                          _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                          firstChild: Container(
                              height: 190,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.zero,
                                      topRight: Radius.zero,
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)
                                  )
                              ),
                              child: Wrap(
                                children: gradeData.map((item){
                                  return Container(
                                    margin: EdgeInsets.all(5),
                                    child: FlatButton(
                                      minWidth: 60,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: Text(
                                          item,
                                          style: TextStyle(color: Colors.black, fontSize: 12)),
                                      color: Color(0xFFF0F0F0),
                                      onPressed: () {
                                        setState(() {
                                          gradeSet = item;
                                          chooseVisible = false;
                                          secondBtn = false;
                                        });
                                      },
                                    ),
                                  );
                                }).toList(),
                              )
                          ),
                          secondChild: Container(
                            height: 190,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.zero,
                                    topRight: Radius.zero,
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)
                                )
                            ),
                            child: Wrap(
                              children: kindData.map((item){
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  child: FlatButton(
                                    minWidth: 60,
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                    ),
                                    child: Text(
                                        item,
                                        style: TextStyle(color: Colors.black, fontSize: 12)),
                                    color: Color(0xFFF0F0F0),
                                    onPressed: () {
                                      setState(() {
                                        kindSet = item;
                                        chooseVisible = false;
                                        secondBtn = false;
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            setState(() {
                              chooseVisible = false;
                            });
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(ScreenUtil.screenHeight - 2000),
                            width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
                            color: Color(0xBB000000),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
          )
        ],
      ),
    );
  }
}

