import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';
import 'package:image_picker/image_picker.dart';

class Achievement extends StatefulWidget {
  @override
  _AchievementState createState() => _AchievementState();
}

class _AchievementState extends State<Achievement> {
  var renderObject = {};
  @override
  void initState() {
    void getRenderInfo(cookie) async{
      var result = await HttpUtils.request(
        '/api_get_person_info?r_id=$cookie',
        method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      setState(() {
        renderObject = res.data;
      });
    }
    void getCookie() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://www.routereading.com/api_login'));
      getRenderInfo(cookies[0].value);
    }
    getCookie();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 375, height: 731)..init(context);
    return Scaffold(
      body: Container(
        width: ScreenUtil().setWidth(ScreenUtil.screenWidth),
        decoration: BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(top: 85, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        final picker = ImagePicker();
                        var pickedFile = await picker.getImage(source: ImageSource.gallery);
                        print(pickedFile.path);
                        String path = pickedFile.path;
                        var name = path.substring(path.lastIndexOf("/") + 1, path.length);
                        var suffix = name.substring(name.lastIndexOf(".") + 1, name.length);
                        FormData formData = new FormData.fromMap({
                          'name': 'media',
                          'file': MultipartFile.fromFile(pickedFile.path, filename: "avatar.img"),
                          // "media": MultipartFile.fromFile(pickedFile.path, filename: "avatar.img")
                        });
                        var dio = Dio();
                        try {
                          var res = await dio.post('http://localhost:3000/api_send_avatar', data: formData, options: new Options(contentType: 'multipart/form-data'));
                          print(res);
                        } catch(e){
                          print(e.toString());
                        }
                        // var res = await HttpUtils.request(
                        //   'http://rdmint-admin.baicizhan.com/api/abtest/upfile/images',
                        //   method: HttpUtils.POST,
                        //   data: {
                        //     'media': formData
                        //   }
                        // );
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(image: DecorationImage(image: renderObject['avatar'] != null ? NetworkImage('${renderObject['avatar']}') : NetworkImage(''), fit: BoxFit.cover), border: Border.all(color: Colors.grey, width: 0.5), borderRadius: BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('${renderObject['nickname']}', style: TextStyle(color: Color(0xFF282828), fontSize: 18, fontWeight: FontWeight.w600))
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, '/setting');
                  },
                  child: Image.asset('images/icon_more.png', width: 25, height: 25),
                )
              ],
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('已阅读', style: TextStyle(color: Color(0xFF646464)),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${renderObject['info_detail']['all_words']}', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(width: 6),
                    Text('字', style: TextStyle(color: Color(0xFF646464))),
                    Container(
                      height: 14,
                      child: VerticalDivider(
                        width: 21,
                        thickness: 2,
                        color: Color(0xFFDCDCDC),
                      ),
                    ),
                    Text('${renderObject['info_detail']['days']}', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(width: 6),
                    Text('天', style: TextStyle(color: Color(0xFF646464))),
                  ],
                )
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('词汇量', style: TextStyle(color: Color(0xFF646464)),)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${renderObject['info_detail']['now_voc']}', style: TextStyle(color: Color(0xff282828), fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(width: 20)
                  ],
                )
              ],
            ),
            SizedBox(height: 44),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/bookshelf');
                },
                child: Container(
                  width: 374,
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFFFFEBD9),
                          Color(0xFFFDE1CA),
                        ],
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 36),
                              Text('书架', style: TextStyle(color: Color(0xff282828), fontSize: 18)),
                              SizedBox(height: 4),
                              Text('正在阅读 ${renderObject['info_detail']['is_read_book'].length} 本，共 ${renderObject['info_detail']['all_books'].length} 本', style: TextStyle(color: Color(0xFF646464), letterSpacing: 1))
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/gold_book.png', width: 120, height: 120)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                child: Container(
                  width: 374,
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFFE4F1FF),
                          Color(0xFFB2D3F3),
                        ],
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 36),
                              Text('单词本', style: TextStyle(color: Color(0xff282828), fontSize: 18)),
                              SizedBox(height: 4),
                              Text('已添加 ${renderObject['info_detail']['word_book'].length} 个单词', style: TextStyle(color: Color(0xFF646464), letterSpacing: 1))
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/blue_word.png', width: 120, height: 120)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/note');
                },
                child: Container(
                  width: 374,
                  height: 120,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          Color(0xFFE4F1FF),
                          Color(0xFFB2D3F3),
                        ],
                      )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 36),
                              Text('阅读笔记', style: TextStyle(color: Color(0xff282828), fontSize: 18)),
                              SizedBox(height: 4),
                              Text('共 ${renderObject['note_count']} 条', style: TextStyle(color: Color(0xFF646464), letterSpacing: 1))
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('images/note_pic.png', width: 120, height: 120)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
