import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int finishNum = 0;
  int allNum = 3;
  int option = 3;
  var renderObject = [];
  bool isExplain = true;
  var questionCollection = {
    'question': '',
    'option1': '',
    'option2': '',
    'option3': '',
    'answer': 0,
    'explain': ''
  };
  bool lastOne = false;
  bool isRight = true;
  @override
  void initState(){
    void getRenderInfo(value,book) async {
      var res = await HttpUtils.request(
        '/get_question_info?a_id=$value&book_id=$book',
        method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
      print(result.data[0]);
      setState(() {
        renderObject = result.data;
        questionCollection = {
          'question': result.data[0]['question']['en'],
          'option1': result.data[0]['options'][0]['en'],
          'option2': result.data[0]['options'][1]['en'],
          'option3': result.data[0]['options'][2]['en'],
          'answers': result.data[0]['answers'][0],
          'explain': result.data[0]['analysis']
        };
      });
    }
    void getCookie() async {
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      String article = '';
      String book = '';
      for (var i in cookies) {
        if (i.name == 'articleId') {
          article = i.value;
        }
        if (i.name == 'select_book') {
          book = i.value;
        }
      }
      getRenderInfo(article, book);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Offstage(
              offstage: !isExplain,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 89, left: 18, right: 18),
                decoration: BoxDecoration(color: Color(0xFFFEECC8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 331,
                      height: 52,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('课后题', style: TextStyle(color: Color(0xFF524832), fontSize: 20, fontWeight: FontWeight.w600)),
                              SizedBox(width: 9),
                              Text('${finishNum}', style: TextStyle(color: Color(0xFF524832), fontSize: 18, fontWeight: FontWeight.w600)),
                              Text(' / ${allNum}', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 18, fontWeight: FontWeight.w600),)
                            ],
                          ),
                          SizedBox(height: 18),
                          Container(
                            width: 331,
                            height: 4,
                            decoration: BoxDecoration(color: Color(0xFFA0A0A0), borderRadius: BorderRadius.all(Radius.circular(2))),
                            child: Stack(
                              children: [
                                Container(
                                  width: 331,
                                  height: 4,
                                  decoration: BoxDecoration(color: Color(0xFFA0A0A0), borderRadius: BorderRadius.all(Radius.circular(2))),
                                ),
                                Container(
                                  width: (finishNum / allNum) * 331,
                                  height: 4,
                                  decoration: BoxDecoration(color: Color(0xFF524832), borderRadius: BorderRadius.all(Radius.circular(2))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35),
                    Container(
                      width: 339,
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 27),
                      decoration: BoxDecoration(color: Color(0xFFFFFBEB), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 303,
                            child: Text('${questionCollection['question']}', style: TextStyle(color: Color(0xFF282828), fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 18),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if (option != 0) {
                                  option = 0;
                                }
                              });
                            },
                            child: Container(
                                width: 303,
                                height: 90,
                                padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                                decoration: BoxDecoration(color: Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      child: option == 0 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('A', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 246,
                                      height: 36,
                                      child: Wrap(
                                        children: [Text('${questionCollection['option1']}', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SizedBox(height: 9),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if (option != 1) {
                                  option = 1;
                                }
                              });
                            },
                            child: Container(
                                width: 303,
                                height: 90,
                                padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                                decoration: BoxDecoration(color: Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      child: option == 1 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('B', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 246,
                                      height: 36,
                                      child: Wrap(
                                        children: [Text('${questionCollection['option2']}', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          ),
                          SizedBox(height: 9),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                if (option != 2) {
                                  option = 2;
                                }
                              });
                            },
                            child: Container(
                                width: 303,
                                height: 90,
                                padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                                decoration: BoxDecoration(color: Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      child: option == 2 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('C', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                                    ),
                                    SizedBox(width: 5),
                                    Container(
                                      width: 246,
                                      height: 36,
                                      child: Wrap(
                                        children: [Text('${questionCollection['option3']}', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                      ),
                                    )
                                  ],
                                )
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: (){
                        if (option < 3) {
                          setState(() {
                            if (finishNum == 2) {
                              lastOne = true;
                            }
                            if (option == questionCollection['answers']) {
                              isRight = true;
                            } else {
                              isRight = false;
                            }
                            isExplain = false;
                          });
                        }
                      },
                      child:  Container(
                        width: 339,
                        height: 43,
                        decoration: BoxDecoration(color: option == 3 ? Color(0x33524832) : Color(0xFF524832), borderRadius: BorderRadius.all(Radius.circular(45))),
                        child: Center(
                          child: Text('提交', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Offstage(
              offstage: isExplain,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 89, left: 18, right: 18),
                decoration: BoxDecoration(color: Color(0xFFFEECC8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 339,
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 27),
                      decoration: BoxDecoration(color: Color(0xFFFFFBEB), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 303,
                            child: Text('${questionCollection['question']}', style: TextStyle(color: Color(0xFF282828), fontSize: 18, fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: 18),
                          Container(
                              width: 303,
                              height: 90,
                              padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                              decoration: BoxDecoration(color: option == 0 ? isRight ? Color(0xFF01B4AB) : Color(0xFFFFC9D0) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    child: Text('A', style: TextStyle(color: option == 0 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 246,
                                    height: 36,
                                    child: Wrap(
                                      children: [Text('${questionCollection['option1']}', style: TextStyle(color: option == 0 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                    ),
                                  )
                                ],
                              )
                          ),
                          SizedBox(height: 9),
                          Container(
                              width: 303,
                              height: 90,
                              padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                              decoration: BoxDecoration(color: option == 1 ? isRight ? Color(0xFF01B4AB) : Color(0xFFFFC9D0) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    child: Text('B', style: TextStyle(color: option == 1 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 246,
                                    height: 36,
                                    child: Wrap(
                                      children: [Text('${questionCollection['option2']}', style: TextStyle(color: option == 1 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                    ),
                                  )
                                ],
                              )
                          ),
                          SizedBox(height: 9),
                          Container(
                              width: 303,
                              height: 90,
                              padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                              decoration: BoxDecoration(color: option == 2 ? isRight ? Color(0xFF01B4AB) : Color(0xFFFFC9D0) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 15,
                                    height: 15,
                                    child: Text('C', style: TextStyle(color: option == 2 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                                  ),
                                  SizedBox(width: 5),
                                  Container(
                                    width: 246,
                                    height: 36,
                                    child: Wrap(
                                      children: [Text('${questionCollection['option3']}', style: TextStyle(color: option == 2 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
                                    ),
                                  )
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    Offstage(
                      offstage: isRight,
                      child: Container(
                        width: 339,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(color: Color(0xFFFFFBEB), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 27.0), blurRadius: 54.0, spreadRadius: 1.0)]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('正确答案 ${questionCollection['answers'] == 0 ? 'A' : questionCollection['answers'] == 1 ? 'B' : 'C'}', style: TextStyle(color: Color(0xFF4E442F), fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(height: 8),
                            Divider(),
                            SizedBox(height: 9),
                            Text('解析', style: TextStyle(color: Color(0xFF4E442F), fontSize: 14, fontWeight: FontWeight.w500)),
                            SizedBox(height: 5),
                            Text('${questionCollection['explain']}', style: TextStyle(color: Color(0xFF4E442F)))
                          ],
                        ),
                      ),
                    ),
                    Offstage(
                      offstage: !isRight,
                      child: Container(
                        width: 339,
                        padding: EdgeInsets.all(18),
                        decoration: BoxDecoration(color: Color(0xFFFFFBEB), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 27.0), blurRadius: 54.0, spreadRadius: 1.0)]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('解析', style: TextStyle(color: Color(0xFF4E442F), fontSize: 14, fontWeight: FontWeight.w500)),
                            SizedBox(height: 5),
                            Text('${questionCollection['explain']}', style: TextStyle(color: Color(0xFF4E442F)))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if (finishNum == 0) {
                            questionCollection = {
                              'question': renderObject[1]['question']['en'],
                              'option1': renderObject[1]['options'][0]['en'],
                              'option2': renderObject[1]['options'][1]['en'],
                              'option3': renderObject[1]['options'][2]['en'],
                              'answers': renderObject[1]['answers'][0],
                              'explain': renderObject[1]['analysis']
                            };
                          } else if (finishNum == 1) {
                            questionCollection = {
                              'question': renderObject[2]['question']['en'],
                              'option1': renderObject[2]['options'][0]['en'],
                              'option2': renderObject[2]['options'][1]['en'],
                              'option3': renderObject[2]['options'][2]['en'],
                              'answers': renderObject[2]['answers'][0],
                              'explain': renderObject[2]['analysis']
                            };
                          }
                          finishNum ++;
                          isExplain = true;
                          option = 3;
                        });
                        if (lastOne) {
                          Navigator.pushNamed(context, '/today');
                        }
                        // Navigator.pushNamed(context, '/explain');
                      },
                      child:  Container(
                        width: 339,
                        height: 43,
                        decoration: BoxDecoration(color: Color(0xFF524832), borderRadius: BorderRadius.all(Radius.circular(45))),
                        child: Center(
                          child: Text(lastOne ? '完成' : '下一题', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
