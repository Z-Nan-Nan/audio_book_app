import 'dart:typed_data';

import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/rendering.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';

class ShareBook extends StatefulWidget {
  @override
  _ShareBookState createState() => _ShareBookState();
}

class _ShareBookState extends State<ShareBook> {
  var tipsShow = true;
  Timer _countdownTimer;
  var renderObject = {};
  String comment = '太棒了，恭喜你完成人生中的第一本英文书！太棒了，恭喜你完成人生中的第一本英文书！';
  int starCount = 1;
  // get globalKey => null;
  static Future<void> saveImage(GlobalKey globalKey) async {
    RenderRepaintBoundary boundary =
    globalKey.currentContext.findRenderObject();
    var image = await boundary.toImage(pixelRatio: 6.0);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData.buffer.asUint8List();
    // final result = await ImageGallerySaver.saveImage(pngBytes,
    //     quality: 60, name: "分享图片");
    // final result = await ImageGallerySaver.save(pngBytes);
    final result = await ImageGallerySaver.saveImage(pngBytes);
    if (result) {
      print('ok');
      // toast("保存成功", wring: false);
    } else {
      print('error');
    }
    // if (Platform.isIOS) {
    //   var status = await Permission.photos.status;
    //   if (status.isUndetermined) {
    //     Map statuses = await [
    //       Permission.photos,
    //     ].request();
    //     saveImage(globalKey);
    //   }
    //   if (status.isGranted) {
    //     final result = await ImageGallerySaver.saveImage(pngBytes,
    //       quality: 60, name: "hello");
    //     if (result) {
    //     print('ok');// toast("保存成功", wring: false);
    //   } else {
    //     print('error');// toast("保存失败");
    //   }
    //   }if (status.isDenied) {
    //     print("IOS拒绝");
    //   }
    // }
    // else if (Platform.isAndroid) {var status = await Permission.storage.status;if (status.isUndetermined) {
    //   Map statuses = await [
    //     Permission.storage,
    //   ].request();
    //   saveImage(globalKey);
    // }if (status.isGranted) {
    //   print("Android已授权");final result = await ImageGallerySaver.saveImage(pngBytes, quality: 60);if (result != null) {
    //     print('ok');// toast("保存成功", wring: false);
    //   } else {
    //     print('error');// toast("保存失败");
    //   }
    // }if (status.isDenied) {
    //   print("Android拒绝");
    // }
    // }
  }
  @override
  void initState() {
    void getRenderInfo(info, book) async{
      var result = await HttpUtils.request(
          '/api_get_share_book_info?r_id=$info&book_id=$book',
          method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        renderObject = res.data;
        comment = res.data['share_comment'];
      });
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
      for (var item in cookies) {
        if (item.name == 'share_book_id') {
          getRenderInfo(cookies[0].value, item.value);
        }
        if (item.name == 'share_book_rate') {
          setState(() {
            starCount = int.parse(item.value);
          });
        }
      }
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey = GlobalKey();
    _countdownTimer = new Timer.periodic(new Duration(seconds: 2), (timer) {
      setState(() {
        tipsShow = false;
        if (_countdownTimer != null) {
          _countdownTimer.cancel();
        }
      });
    });
    return Scaffold(
      body: RepaintBoundary(
        key: globalKey,
        child: Container(
            child: Stack(
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
                          Book(height: 238, coverUrl: '${renderObject['book_detail']['img_src']}'),
                          SizedBox(height: 28),
                          GestureDetector(
                            onTap: (){
                              print('tap');
                              saveImage(globalKey);
                            },
                            child: Text('${renderObject['book_detail']['name_cn']}', style: TextStyle(color: Colors.white, fontSize: 25)),
                          ),
                          SizedBox(height: 9),
                          Text('第${renderObject['book_detail']['term']}期', style: TextStyle(color: Colors.white)),
                          SizedBox(height: 9),
                          Text('共${renderObject['book_detail']['chapter_num'].length}章，${renderObject['book_detail']['words']}字', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 11)),
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
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(11), image: DecorationImage(image: NetworkImage('${renderObject['user_detail']['avatar']}'))),
                                    ),
                                    SizedBox(width: 9),
                                    Text('${renderObject['user_detail']['nickname']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),)
                                  ],
                                ),
                                SizedBox(height: 9),
                                Text('${renderObject['find_book']['date']} 读完，在薄荷阅读的第 ${renderObject['find_book']['rank']} 本书', style: TextStyle(color: Color(0xFFA0A0A0),fontSize: 13)),
                                SizedBox(height: 9),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('评分', style: TextStyle(color: Colors.white, fontSize: 13)),
                                    SizedBox(width: 9),
                                    Image.asset('images/star_white.png', width: 18, height: 18),
                                    SizedBox(width: 7),
                                    starCount > 1 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                    SizedBox(width: 7),
                                    starCount > 2 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                    SizedBox(width: 7),
                                    starCount > 3 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                    SizedBox(width: 7),
                                    starCount > 4 ? Image.asset('images/star_white.png', width: 18, height: 18) : Image.asset('images/star_transparent.png', width: 18, height: 18),
                                  ],
                                ),
                                SizedBox(height: 18),
                                Text('$comment', style: TextStyle(color: Colors.white, fontSize: 13))
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
                          child: Text('按下书本名字即可保存哦', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                )
              ],
            )
        ),
      )
    );
  }
}
