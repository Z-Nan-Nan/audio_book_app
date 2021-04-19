import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:audio_book_app/widgets/usual/login.dart';
import 'package:audio_book_app/tools/StatusCheck.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'dart:async';

class Sign extends StatefulWidget {
  @override
  _SignState createState() => _SignState();
}

class _SignState extends State<Sign> {
  String userIdLength = '';
  String passwordLength = '';
  String usernameLength = '';
  var _radioGroupValue = '男';
  bool signFail = false;
  var _dateTime = DateTime.now();
  bool firstStep = true;
  String signDesc = '';
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
                Text('欢迎加入浅荷阅读', style: TextStyle(color: Color(0xFF282828), fontSize: 22, fontWeight: FontWeight.w600)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/wish1.png'), fit: BoxFit.cover)),
                    )
                  ],
                ),
                Offstage(
                  offstage: !firstStep,
                  child: Container(
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value){
                            setState(() {
                              userIdLength = value;
                            });
                          },
                          decoration: InputDecoration(
                              counterText: '${userIdLength.length}/10',
                              helperText: '用户名长度为6-10个字母',
                              labelText: '请设置您的账号',
                              labelStyle: TextStyle(color:Color(0xFF01B4AB))
                          ),
                        ),
                        SizedBox(height: 18),
                        TextField(
                          onChanged: (value){
                            setState(() {
                              passwordLength = value;
                            });
                          },
                          decoration: InputDecoration(
                              counterText: '${passwordLength.length}/15',
                              helperText: '密码长度为8-15个字母和数字混合',
                              labelText: '请设置您的密码',
                              labelStyle: TextStyle(color:Color(0xFF01B4AB))
                          ),
                        ),
                        SizedBox(height: 18),
                        TextField(
                          onChanged: (value){
                            setState(() {
                              usernameLength = value;
                            });
                          },
                          decoration: InputDecoration(
                              counterText: '${usernameLength.length}/8',
                              helperText: '用户名长度为4-8个字符',
                              labelText: '请设置您的昵称',
                              labelStyle: TextStyle(color:Color(0xFF01B4AB))
                          ),
                        ),
                        SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  firstStep = false;
                                });
                              },
                              child: Icon(Icons.arrow_forward, size: 28, color: Color(0xFF01B4AB)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Offstage(
                  offstage: firstStep,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('请告诉我们您的性别：', style: TextStyle(color:Color(0xFF01B4AB))),
                        Row(
                          children: [
                            Text('男', style: TextStyle(color:Color(0xFF01B4AB))),
                            Radio(
                              value: '男',
                              groupValue: _radioGroupValue,
                              activeColor: Color(0xFF01B4AB),
                              onChanged: (value){
                                setState(() {
                                  _radioGroupValue = value;
                                });
                              },
                            ),
                            Text('女', style: TextStyle(color:Color(0xFF01B4AB))),
                            Radio(
                              value: '女',
                              groupValue: _radioGroupValue,
                              activeColor: Color(0xFF01B4AB),
                              onChanged: (value){
                                setState(() {
                                  _radioGroupValue = value;
                                });
                              },
                            ),
                            Text('保密', style: TextStyle(color:Color(0xFF01B4AB))),
                            Radio(
                              value: '保密',
                              groupValue: _radioGroupValue,
                              activeColor: Color(0xFF01B4AB),
                              onChanged: (value){
                                setState(() {
                                  _radioGroupValue = value;
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 18),
                        Text('请告诉我们您的生日：', style: TextStyle(color:Color(0xFF01B4AB))),
                        SizedBox(height: 10),
                        Container(
                          width: 270,
                          height: 100,
                          child: CupertinoDatePicker(
                            initialDateTime: _dateTime,
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (date) {
                              setState(() {
                                _dateTime = date;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 27),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()async {
                                var date = '${_dateTime.year}/${_dateTime.month}/${_dateTime.day}';
                                var result = await HttpUtils.request(
                                    '/api_sign',
                                    method: HttpUtils.POST,
                                    data: {
                                      'account': userIdLength,
                                      'password': passwordLength,
                                      'nickname': usernameLength,
                                      'sex': _radioGroupValue,
                                      'age': date
                                    }
                                );
                                var res = StatusCheck.fromJSON(result);
                                if (res.status == 1) {
                                  setState(() {
                                    signFail = true;
                                    signDesc = res.desc;
                                  });
                                  const timeout = const Duration(seconds: 2);
                                  Timer(timeout, () { //callback function
                                    setState(() {
                                      signFail = false;
                                    });
                                  });
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => route == null);
                                } else {
                                  setState(() {
                                    signFail = true;
                                    signDesc = res.desc;
                                  });
                                  const timeout = const Duration(seconds: 2);
                                  Timer(timeout, () { //callback function
                                    setState(() {
                                      signFail = false;
                                    });
                                  });
                                }
                              },
                              child: Icon(Icons.arrow_forward, size: 28, color: Color(0xFF01B4AB)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/wish2.png'), fit: BoxFit.cover)),
                    ),
                    SizedBox(width: 35),
                    Container(
                      width: 120,
                      height: 180,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage('images/wish3.png'), fit: BoxFit.cover)),
                    )
                  ],
                ),
              ],
            ),
          ),
          Offstage(
            offstage: !signFail,
            child: Dialog(
              child: Container(
                width: 70,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Text(signDesc),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
