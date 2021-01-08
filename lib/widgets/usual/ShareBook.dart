import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ShareBook extends StatefulWidget {
  @override
  _ShareBookState createState() => _ShareBookState();
}

class _ShareBookState extends State<ShareBook> {
  var tipsShow = true;
  Timer _countdownTimer;

  get globalKey => null;
  @override
  Widget build(BuildContext context) {
    _countdownTimer = new Timer.periodic(new Duration(seconds: 2), (timer) {
      setState(() {
        tipsShow = false;
        if (_countdownTimer != null) {
          _countdownTimer.cancel();
        }
      });
    });
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.black, Color(0xFF282828)])),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 274,
                decoration: BoxDecoration(color: Colors.black, image: DecorationImage(image: AssetImage('images/bgLight.png'), fit: BoxFit.cover,)),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 110),
                    Book(height: 238, coverUrl: 'https://ali.baicizhan.com/readin/images/2020041623174187.png'),
                    SizedBox(height: 28),
                    Text('阳光下的罪恶', style: TextStyle(color: Colors.white, fontSize: 25)),
                    SizedBox(height: 9),
                    Text('68期经典 阿加莎系列 3/4', style: TextStyle(color: Colors.white)),
                    SizedBox(height: 9),
                    Text('共25章，261000字', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11)),
                    SizedBox(height: 22),
                    Container(
                      width: 339,
                      height: 1,
                      decoration: BoxDecoration(color: Color(0xFF3C3C3C)),
                    ),
                    SizedBox(height: 9),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(18),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), color: Color(0xFFD8D8D8)),
                              ),
                              SizedBox(width: 9),
                              Text('请叫我爸爸', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
                            ],
                          ),
                          SizedBox(height: 9),
                          Text('2020.02.26 读完，在薄荷阅读的第 8 本书', style: TextStyle(color: Color(0xFFA0A0A0),fontSize: 13)),
                          SizedBox(height: 9),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('评分', style: TextStyle(color: Colors.white, fontSize: 13)),
                              SizedBox(width: 9),
                              Image.asset('images/star_white.png', width: 18, height: 18),
                              SizedBox(width: 7),
                              Image.asset('images/star_white.png', width: 18, height: 18),
                              SizedBox(width: 7),
                              Image.asset('images/star_white.png', width: 18, height: 18),
                              SizedBox(width: 7),
                              Image.asset('images/star_white.png', width: 18, height: 18),
                              SizedBox(width: 7),
                              Image.asset('images/star_transparent.png', width: 18, height: 18),
                            ],
                          ),
                          SizedBox(height: 18),
                          Text('太棒了，恭喜你完成人生中的第一本英文书！太棒了，恭喜你完成人生中的第一本英文书！', style: TextStyle(color: Colors.white, fontSize: 13))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.height) / 2 - 50,
            left: (MediaQuery.of(context).size.width) / 2 - 100,
            child: Offstage(
              offstage: !tipsShow,
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(color: Colors.black),
                child: Center(
                  child: Text('按下书本即可保存哦', style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
