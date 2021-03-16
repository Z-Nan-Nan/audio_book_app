import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class GoldenMint extends StatefulWidget {
  @override
  _GoldenMintState createState() => _GoldenMintState();
}

class _GoldenMintState extends State<GoldenMint> {
  bool ruleShow = true;
  GlobalKey controlKey = new GlobalKey();
  bool showTopTab = false;
  ScrollController _controller = new ScrollController();
  var renderObject = {};

  @override
  void initState() {
    void getRenderInfo(id)async {
      var result = await HttpUtils.request(
        '/get_gold_info?r_id=$id',
        method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      print(res.data);
      setState(() {
        renderObject = res.data;
      });
    }
    void getCookie()async {
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      getRenderInfo(cookies[0].value);
    }
    getCookie();
    super.initState();
    _controller.addListener(() {
      RenderBox box = controlKey.currentContext.findRenderObject();
      Offset offset = box.localToGlobal(Offset.zero);
      if (_controller.offset - offset.dy < 400) {
        setState(() {
          showTopTab = false;
        });
      }
      if (_controller.offset - offset.dy >= 400) {
        setState(() {
          showTopTab = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: SingleChildScrollView(
              controller: _controller,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 344,
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/mint_top.png'), fit: BoxFit.cover,)),
                  ),
                  Container(
                    key: controlKey,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 132),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        ruleShow = true;
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('任务', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                                          SizedBox(height: 5),
                                          ruleShow ? Container(
                                            width: 29,
                                            height: 1,
                                            color: Colors.black,
                                          ) : Container(
                                            width: 29,
                                            height: 1,
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(width: 37),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      ruleShow = false;
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('兑换', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                                        SizedBox(height: 5),
                                        !ruleShow ? Container(
                                          width: 29,
                                          height: 1,
                                          color: Colors.black,
                                        ) : Container(
                                          width: 29,
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(width: 45),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                    width: 62,
                                    height: 29,
                                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/mint_button_coin.png'), fit: BoxFit.cover,)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('19', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                                        SizedBox(width: 9)
                                      ],
                                    )
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  ruleShow ? Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('任务1', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w500)),
                              SizedBox(height: 9),
                              Container(
                                width: 339,
                                height: 321,
                                padding: EdgeInsets.only(top: 30, left: 18, right: 18, bottom: 18),
                                decoration: BoxDecoration(color: Color(0xFFFEF3DD), borderRadius: BorderRadius.circular(9)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('images/mint_title1.png', width: 265, height: 21,),
                                    SizedBox(height: 9),
                                    Text('*从第1天阅读内容开始，每7天阅读内容为1周', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                    SizedBox(height: 18),
                                    Container(
                                      width: 303,
                                      height: 210,
                                      padding: EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 13),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset('images/goldenmint_finish.png', width: 24, height: 24),
                                                      SizedBox(width: 5),
                                                      Text('0/1', style: TextStyle(color: Color(0xFF595859), fontSize: 11, fontWeight: FontWeight.w600))
                                                    ],
                                                  ),
                                                  SizedBox(height: 9),
                                                  Text('${renderObject['group_name']}', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w500)),
                                                  SizedBox(height: 7),
                                                  Text('第${renderObject['is_week']}周，${renderObject['day_num']}天后进入下周', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                  SizedBox(height: 27),
                                                  Container(
                                                    width: 62,
                                                    height: 22,
                                                    decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.circular(11)),
                                                    child: Center(
                                                        child: Text('去阅读', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: 118,
                                                        height: 118,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(59), gradient: LinearGradient(
                                                            begin: Alignment.bottomCenter,
                                                            end: Alignment.topCenter,
                                                            colors: [Color(0xFFFFC537), Color(0xFFFFEDD0), Colors.transparent],
                                                            stops: [0, renderObject['right_count'] / 21, 1]
                                                        )),
                                                      ),
                                                      Container(
                                                        width: 118,
                                                        height: 118,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(59), border: Border.all(width: 3, color: Color(0xFFF0F0F0))),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text('答对题数', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                              SizedBox(height: 4),
                                                              Text('${renderObject['right_count']}/21', style: TextStyle(color: Color(0xFF282828), fontSize: 22))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.pushNamed(context, '/mintTask');
                                                },
                                                child: Text('查看历史任务达成情况>', style: TextStyle(color: Color(0xFF282828), fontSize: 10, fontWeight: FontWeight.w500)),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 28),
                              Text('任务2', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w500)),
                              SizedBox(height: 9),
                              Container(
                                width: 339,
                                height: 321,
                                padding: EdgeInsets.only(top: 30, left: 18, right: 18, bottom: 18),
                                decoration: BoxDecoration(color: Color(0xFFFEF3DD), borderRadius: BorderRadius.circular(9)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('images/mint_title2.png', width: 265, height: 21,),
                                    SizedBox(height: 27),
                                    Container(
                                      width: 303,
                                      height: 210,
                                      padding: EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 13),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Image.asset('images/goldenmint_finish.png', width: 24, height: 24),
                                                      SizedBox(width: 5),
                                                      Text('0/1', style: TextStyle(color: Color(0xFF595859), fontSize: 11, fontWeight: FontWeight.w600))
                                                    ],
                                                  ),
                                                  SizedBox(height: 9),
                                                  Text('${renderObject['group_name']}', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w500)),
                                                  SizedBox(height: 7),
                                                  Text('100天后过期', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                  SizedBox(height: 27),
                                                  Container(
                                                    width: 62,
                                                    height: 22,
                                                    decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.circular(11)),
                                                    child: Center(
                                                        child: Text('去阅读', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: 118,
                                                        height: 118,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(59), gradient: LinearGradient(
                                                            begin: Alignment.bottomCenter,
                                                            end: Alignment.topCenter,
                                                            colors: [Color(0xFFFFC537), Color(0xFFFFEDD0), Colors.transparent],
                                                            stops: [0, renderObject['finish_num'] / 80, 1]
                                                        )),
                                                      ),
                                                      Container(
                                                        width: 118,
                                                        height: 118,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(59), border: Border.all(width: 3, color: Color(0xFFF0F0F0))),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text('已读天数', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                              SizedBox(height: 4),
                                                              Text('${renderObject['finish_num']}/80', style: TextStyle(color: Color(0xFF282828), fontSize: 22))
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 18),
                                          Divider(),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Text('查看历史任务达成情况>', style: TextStyle(color: Color(0xFF282828), fontSize: 10, fontWeight: FontWeight.w500)),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('规则介绍', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                              SizedBox(height: 9),
                              RichText(text: TextSpan(style: TextStyle(color: Color(0xFF646464), height: 2),
                                  children: [
                                    TextSpan(text: '为了激励大家更好地养成每日阅读英文的良好习惯，薄荷团队为大家准备了额外的奖励活动，只要认真读书答题，就可以获得'),
                                    TextSpan(text: '「金薄荷」', style: TextStyle(fontWeight: FontWeight.w600)),
                                    TextSpan(text: '奖励，用来兑换丰富的产品！')
                                  ])
                              ),
                              SizedBox(height: 27),
                              Text('· 奖品有哪些', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                              SizedBox(height: 9),
                              RichText(text: TextSpan(style: TextStyle(color: Color(0xFF646464), height: 2),
                                  children: [
                                    TextSpan(text: '您可以在'),
                                    TextSpan(text: '「兑换」', style: TextStyle(fontWeight: FontWeight.w600)),
                                    TextSpan(text: '中查看可兑换的奖品和相应的兑换条件')
                                  ])
                              ),
                              SizedBox(height: 27),
                              Text('· 任务可以补做吗？', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                              SizedBox(height: 9),
                              Text('不可以，每周正确率挑战任务只能在每个课程周内完成（课程开课后，每7天阅读内容为1个课程周），每期80天阅读挑战任务只能在开课期间的100天内完成，一旦过期就不能再完成了', style: TextStyle(color: Color(0xFF646464), height: 2),),
                              SizedBox(height: 27),
                              Text('· 课程结束后金薄荷会清空吗？', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                              SizedBox(height: 9),
                              Text('不会，每期获得的金薄荷可以一直累计，合并使用', style: TextStyle(color: Color(0xFF646464), height: 2),),
                              SizedBox(height: 30)
                            ],
                          ),
                        )
                      ],
                    ),
                  ) :
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('实体书奖励', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w500)),
                        SizedBox(height: 9),
                        Text('以下奖励需完成对应课程80天阅读内容以解锁', style: TextStyle(color: Color(0xFF636363), fontSize: 11, fontWeight: FontWeight.w500)),
                        SizedBox(height: 18),
                        Container(
                          width: 339,
                          height: 146,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Color(0x1A000000),offset: Offset(0.0, 10.0), blurRadius: 15.0, spreadRadius: 1.0)]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('images/mint_change_book.png', width: 146, height: 146),
                              Container(
                                padding: EdgeInsets.all(18),
                                color: Colors.white,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('进阶-女性成长', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600)),
                                      SizedBox(height: 9),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset('images/goldenmint_finish.png', width: 24, height: 24),
                                          SizedBox(width: 5),
                                          Text('5', style: TextStyle(color: Color(0xFF636363), fontSize: 13, fontWeight: FontWeight.w600)),
                                        ]
                                      ),
                                      SizedBox(height: 9),
                                      Text('已读天数：60/80', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                      SizedBox(height: 9),
                                      Container(
                                          width: 62,
                                          height: 22,
                                          decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.circular(11)),
                                          child: Center(
                                              child: Text('去阅读', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600))
                                          )
                                      ),
                                    ]
                                )
                              )
                            ]
                          )
                        ),
                        SizedBox(height: 35),
                        Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('常规奖励', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w500)),
                                SizedBox(height: 9),
                                Container(
                                    width: 339,
                                    height: 146,
                                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Color(0x1A000000),offset: Offset(0.0, 10.0), blurRadius: 15.0, spreadRadius: 1.0)]),
                                    child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Image.asset('images/mint_change_book.png', width: 146, height: 146),
                                          Container(
                                              padding: EdgeInsets.all(18),
                                              color: Colors.white,
                                              child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('5元代金券', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600)),
                                                    SizedBox(height: 9),
                                                    Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          Image.asset('images/goldCoin.png', width: 24, height: 24),
                                                          SizedBox(width: 5),
                                                          Text('5', style: TextStyle(color: Color(0xFFF7BE27), fontSize: 13, fontWeight: FontWeight.w600)),
                                                        ]
                                                    ),
                                                    SizedBox(height: 6),
                                                    Text('· 课程和商城周边产品通用', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                    SizedBox(height: 2),
                                                    Text('· 无门槛', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                    SizedBox(height: 2),
                                                    Text('· 不可叠加使用', style: TextStyle(color: Color(0xFF646464), fontSize: 11, fontWeight: FontWeight.w500)),
                                                  ]
                                              )
                                          )
                                        ]
                                    )
                                )
                              ],
                            )
                        ),
                      ],
                    )
                  ),
                  SizedBox(height: 36),
                ],
              ),
            ),
          ),
          Positioned(
              top: 0,
              child: Offstage(
                offstage: !showTopTab,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 88,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        ruleShow = true;
                                      });
                                    },
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text('任务', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                                          SizedBox(height: 5),
                                          ruleShow ? Container(
                                            width: 29,
                                            height: 1,
                                            color: Colors.black,
                                          ) : Container(
                                            width: 29,
                                            height: 1,
                                          )
                                        ],
                                      ),
                                    )
                                ),
                                SizedBox(width: 37),
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      ruleShow = false;
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('兑换', style: TextStyle(color: Color(0xFF282828), fontWeight: FontWeight.w600)),
                                        SizedBox(height: 5),
                                        !ruleShow ? Container(
                                          width: 29,
                                          height: 1,
                                          color: Colors.black,
                                        ) : Container(
                                          width: 29,
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              )
          )
        ],
      ),
    );
  }
}
