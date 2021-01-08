import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  int finishNum = 2;
  int allNum = 3;
  int option = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              height: 403,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 27),
              decoration: BoxDecoration(color: Color(0xFFFFFBEB), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 303,
                    child: Text('Did Mrs Darling know of Peter Pan?', style: TextStyle(color: Color(0xFF282828), fontSize: 18, fontWeight: FontWeight.w500)),
                  ),
                  SizedBox(height: 18),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 15,
                              height: 15,
                              child: option == 1 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('A', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 246,
                              height: 36,
                              child: Wrap(
                                children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
                              child: option == 2 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('B', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 246,
                              height: 36,
                              child: Wrap(
                                children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
                        if (option != 3) {
                          option = 3;
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
                              child: option == 3 ? Image.asset('images/icon_select.png', width: 15, height: 15,): Text('C', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w700)),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 246,
                              height: 36,
                              child: Wrap(
                                children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
               Navigator.pushNamed(context, '/explain');
             },
             child:  Container(
               width: 339,
               height: 43,
               decoration: BoxDecoration(color: option == 0 ? Color(0x33524832) : Color(0xFF524832), borderRadius: BorderRadius.all(Radius.circular(45))),
               child: Center(
                 child: Text('提交', style: TextStyle(color: Colors.white)),
               ),
             ),
           )
          ],
        ),
      ),
    );
  }
}
