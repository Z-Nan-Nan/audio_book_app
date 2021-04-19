import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:audio_book_app/tools/StatusCheck.dart';
import 'package:audio_book_app/routes/home/home.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/net/api.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'dart:async';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String username = '';
  String password = '';
  String loginDesc = '11';
  bool loginError = false;
  Response response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('登录浅荷阅读', style: TextStyle(color: Color(0xFF282828), fontSize: 22, fontWeight: FontWeight.w600)),
                SizedBox(height: 27),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: '账号：',
                      labelStyle: TextStyle(color:Color(0xFF01B4AB))
                  ),
                ),
                SizedBox(height: 27),
                TextField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: '密码：',
                      labelStyle: TextStyle(color:Color(0xFF01B4AB))
                  ),
                ),
                SizedBox(height: 54),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()async {
                        print('${username}--${password}');
                        var result = await HttpUtils.request(
                            '/api_login',
                            method: HttpUtils.POST,
                            data: {
                              'account': username,
                              'password': password
                            }
                        );
                        var res = StatusCheck.fromJSON(result);
                        if (res.status == 1) {
                          Dio().interceptors.add(CookieManager(await Api.cookieJar));
                          List<Cookie> cookies = [
                            new Cookie('rId', res.rId)
                          ];
                          (await Api.cookieJar).saveFromResponse(Uri.parse('http://www.routereading.com/api_login'), cookies);
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => route == null);
                        } else {
                          setState(() {
                            loginDesc = res.desc;
                            loginError = true;
                          });
                          const timeout = const Duration(seconds: 2);
                          Timer(timeout, () { //callback function
                            setState(() {
                              loginError = false;
                            }); // 5s之后
                          });
                        }
                      },
                      child: Container(
                        width: 220,
                        height: 40,
                        decoration: BoxDecoration(color: Color(0xFF01B4AB), borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/sign');
                      },
                      child: Text('还没有账号？点此加入浅荷阅读', style: TextStyle(color: Color(0xFF01B4AB), decoration: TextDecoration.underline)),
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 100,
            child: Stack(
              children: [
                Opacity(
                  opacity: .1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 203,
                    decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFF6E0A), Color(0x00FF6E0A)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 203,
                  padding: EdgeInsets.symmetric(vertical: 33, horizontal: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('images/more_book.png', width: 72, height: 17),
                      SizedBox(height: 13),
                      Container(
                        width: 340,
                        height: 91,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/banner.png'), fit: BoxFit.cover)),
                        child: Center(
                            child: Text('百本好书，尽享英文阅读', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600))
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          Offstage(
            offstage: !loginError,
            child: Dialog(
              child: Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(loginDesc),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
