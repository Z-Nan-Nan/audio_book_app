import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:audio_book_app/tools/DayStatus.dart';
import 'package:audio_book_app/widgets/commons/month.dart';

class Calender extends StatefulWidget {
  @override
  _CalenderState createState() => _CalenderState();
}

class _CalenderState extends State<Calender> {
  ScrollController controller = new ScrollController();
  List courseList = ['41期进阶 商业创新系列', '65期高阶 理想与现实', '65期进阶 迪士尼', '68期入门 环球梦工厂系列', '69期进阶 女性成长系列', '69期进阶 牧羊少年的奇幻之旅', '72期高阶 理想与现实'];
  List <DayStatus> daysList = [
    DayStatus.fromJSON({
      'year': 2020,
      'month': 11,
      'startDay': 7,
      'days': [
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 0
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        },
        {
          'read': 2
        }]
    }),
    DayStatus.fromJSON({
      'year': 2020,
      'month': 12,
      'startDay': 2,
      'days': [
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },
        {
          'read': 1
        },{
          'read': 1
        }]
    }),
    DayStatus.fromJSON({
      'year': 2021,
      'month': 1,
      'startDay': 5,
      'days': [
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        },
        {
          'read': 3
        }]
    })
  ];
  bool modalVisible = false;
  @override
  Widget build(BuildContext context) {
    var nowTime = DateTime.now();
    print(nowTime.day);
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 164, bottom: 200),
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(),

              ],
            ),
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 78, left: 18, right: 18, bottom: 9),
              decoration: BoxDecoration(color: Colors.white),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Day 01', style: TextStyle(color: Color(0xFF282828), fontSize: 22, fontWeight: FontWeight.w600, fontFamily: 'NewYork')),
                        Container(
                          width: 208,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('正读 38', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                              SizedBox(width: 14),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFFFFD3AF), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('补读 4', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                              SizedBox(width: 14),
                              Container(
                                width: 7,
                                height: 7,
                                decoration: BoxDecoration(color: Color(0xFFF0F0F0), borderRadius: BorderRadius.all(Radius.circular(4))),
                              ),
                              SizedBox(width: 4),
                              Text('未完成 6', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 13)),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 27),
                    Container(
                      width: 320,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('一', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('二', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('三', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('四', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('五', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('六', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                          Text('日', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    SizedBox(height: 9),
                    // Month(year: daysList[0].year, nowMonth: month1, pos: 0,),
                    Container(
                      width: 375,
                      height: 400,
                      child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Month(year: daysList[0].year, nowMonth: daysList[0].startMonth, pos: 0, daysMap: daysList[0].days, startDay: daysList[0].startDay),
                              Month(year: daysList[1].year, nowMonth: daysList[1].startMonth, pos: 1, daysMap: daysList[1].days, startDay: daysList[1].startDay),
                              Month(year: daysList[2].year, nowMonth: daysList[2].startMonth, pos: 2, daysMap: daysList[2].days, startDay: daysList[2].startDay),
                              SizedBox(height: 80)
                            ],
                          )
                      ),
                    )
                    // Month(year: daysList[0].year, nowMonth: month3, pos: 2)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                  width: 339,
                  height: 188,
                  padding: EdgeInsets.only(top: 18, bottom: 18, left: 18),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x26000000),offset: Offset(0.0, 18.0), blurRadius: 36.0, spreadRadius: 1.0)]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('68期入门 纳尼亚传奇：狮子、女巫和魔衣橱', style: TextStyle(color: Color(0xFF01B4AB), fontWeight: FontWeight.w600)),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  modalVisible = true;
                                });
                              },
                              child: modalVisible ? Image.asset('images/icon_toUp.png', width: 13, height: 13) : Image.asset('images/icon_arrow_right2.png', width: 13, height: 13),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        height: 116,
                        width: 323,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Book(height: 115, coverUrl: 'https://ali.baicizhan.com/readin/images/2020051117451690.jpg'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: 'https://ali.baicizhan.com/readin/images/2020060517233085.jpeg'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: 'https://ali.baicizhan.com/readin/images/2020081311083151.jpeg'),
                              SizedBox(width: 14),
                              Book(height: 115, coverUrl: 'https://ali.baicizhan.com/readin/images/202004281128356.jpeg'),
                              SizedBox(width: 14),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Offstage(
            offstage: !modalVisible,
            child: Stack(
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      modalVisible = false;
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: Color(0x99000000)),
                  ),
                ),
                Positioned(
                  bottom: 300,
                  right: 50,
                  child: Container(
                    width: 270,
                    height: courseList.length <= 3 ? double.parse('${58 * courseList.length}') : 174,
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: courseList.map((item){
                          return Container(
                            height: 58,
                            padding: EdgeInsets.all(6),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${item}', style: TextStyle(color: Color(0xFF282828), fontSize: 16)),
                                Divider()
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
