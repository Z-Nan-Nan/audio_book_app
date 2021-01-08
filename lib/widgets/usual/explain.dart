import 'package:flutter/material.dart';

class Explain extends StatefulWidget {
  @override
  _ExplainState createState() => _ExplainState();
}

class _ExplainState extends State<Explain> {
  final int isSelect = 3;
  final String answer = 'B';
  final bool lastOne = true;
  final bool isRight = true;
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
                  Container(
                      width: 303,
                      height: 90,
                      padding: EdgeInsets.only(left: 18, right: 18, bottom: 27),
                      decoration: BoxDecoration(color: isSelect == 1 ? Color(0xFF01B4AB) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            child: Text('A', style: TextStyle(color: isSelect == 1 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 246,
                            height: 36,
                            child: Wrap(
                              children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: isSelect == 1 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
                      decoration: BoxDecoration(color: isSelect == 2 ? Color(0xFF01B4AB) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            child: Text('B', style: TextStyle(color: isSelect == 2 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 246,
                            height: 36,
                            child: Wrap(
                              children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: isSelect == 2 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
                      decoration: BoxDecoration(color: isSelect == 3 ? isRight ? Color(0xFF01B4AB) : Color(0xFFFFC9D0) : Color(0xFFF3ECD3), borderRadius: BorderRadius.all(Radius.circular(9))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            child: Text('C', style: TextStyle(color: isSelect == 3 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w700)),
                          ),
                          SizedBox(width: 5),
                          Container(
                            width: 246,
                            height: 36,
                            child: Wrap(
                              children: [Text('Yes, she heard something about him when she was young. ', style: TextStyle(color: isSelect == 3 ? Colors.white : Color(0xFF524832), fontWeight: FontWeight.w500, height: 2)),],
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
                    Text('正确答案 ${answer}', style: TextStyle(color: Color(0xFF4E442F), fontSize: 16, fontWeight: FontWeight.w600)),
                    SizedBox(height: 8),
                    Divider(),
                    SizedBox(height: 9),
                    Text('解析', style: TextStyle(color: Color(0xFF4E442F), fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 5),
                    Text('文中提到：I had two older brothers…Being the third son of the family. 所以选 A', style: TextStyle(color: Color(0xFF4E442F)))
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
                    Text('文中提到：I had two older brothers…Being the third son of the family. 所以选 A', style: TextStyle(color: Color(0xFF4E442F)))
                  ],
                ),
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
                decoration: BoxDecoration(color: Color(0xFF524832), borderRadius: BorderRadius.all(Radius.circular(45))),
                child: Center(
                  child: Text(lastOne ? '完成' : '提交', style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
