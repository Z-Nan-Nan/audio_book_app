import 'dart:convert';
import 'dart:async';
import 'package:audio_book_app/tools/AudioBookData.dart';
import 'package:audio_book_app/widgets/commons/paragraph.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:audio_book_app/net/api.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';
import 'package:audioplayers/audioplayers.dart';

class AudioBook extends StatefulWidget {
  @override
  _AudioBookState createState() => _AudioBookState();
}

class _AudioBookState extends State<AudioBook> {
  AudioPlayer audioPlayer = AudioPlayer();
  String audioUrl = '';
  List<AudioBookData> audioBookData = [];
  var renderObject = {};
  List chapterList = [];
  bool clickAble = true;
  int selectId = null;
  bool editModal = false;
  bool createModal = false;
  double modalHeight = 100.0;
  bool isPlay = false;
  int isMin = 0;
  int isSecond = 0;
  int allMin = 0;
  int allSecond = 10;
  double process = 0;
  Timer _timer;
  double opacityLevel = 0.0;
  int jumpTime = 0;
  String newNote = '';
  String isNote = '';
  bool hasNote = false;
  var selectArticle = 'a_0001';
  var fontSizeSet = {
    'theme': 'medium',
    'title': 34.0,
    'vocabulary': 16.0,
    'explain': 13.0,
    'rawWord': 16.0,
    'story': 13.0,
    'question': 16.0,
    'articleNum': 15.0,
    'note': 16.0,
    'article': 18.0
  };
  String theme = 'brown';
  TextEditingController textController = new TextEditingController();
  changeOpacity() {
    setState(
      () => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0
    );
  }
  setClickAble(i) {
    setState(() {
      clickAble = false;
      selectId = i;
      var flag = false;
      for (var j in renderObject['note_collection']) {
        if (j['pos'] == selectId - 3) {
          setState(() {
            flag = true;
            isNote = j['content'];
            hasNote = true;
          });
        }
      }
      if (!flag) {
        setState(() {
          isNote = '';
          hasNote = false;
        });
      }
      if (selectId == 3) {
        setState(() {
          jumpTime = 0;
        });
      } else {
        setState(() {
          jumpTime = (double.parse(renderObject['audio'][0]['audio_times'][selectId - 4]['end_time']) * 1000).floor();
        });
      }
    });
  }
  setModal(height) {
    setState(() {
      modalHeight = height;
    });
  }
  makeLine(list) {
    String line = '';
    for (var i = 0; i < line.length; i++) {
      if (i == line.length - 1) {
        line += list[i];
      } else {
        line += '${list[i]} / ';
      }
    }
  }
  play() async {
    int result = await audioPlayer.play(audioUrl);
    if (result == 1) {
      setState(() {
        process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 223;
        const timeout = const Duration(seconds: 1);
        _timer = Timer.periodic(timeout, (timer) {
          if (process >= 223) {
            process = 223;
          } else {
            if (isSecond == 60) {
              isSecond = 0;
              setState(() {
                isMin++;
              });
            }
            process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 223;
            if (isMin * 60 + isSecond <= allMin * 60 + allSecond - 1) {
              print('${isSecond}');
              setState(() {
                isSecond++;
              });
            }
          }
        });
      });
      print('play success');
    } else {
      print('play failed');
    }
  }
  pause() async {
    int result = await audioPlayer.pause();
    if (result == 1) {
      // success
      setState(() {
        if (_timer != null) {
          _timer.cancel();
          _timer = null;
        }
      });
      print('pause success');
    } else {
      print('pause failed');
    }
  }
  jump(select) async {
    int result = await audioPlayer.resume();
    print((isMin * 60 + isSecond * 1000) is int);
    if (result == 1) {
      audioPlayer.onAudioPositionChanged.listen((p) async {
        setState(() {
          isMin = p.inMinutes;
          if (select) {
            if (p.inSeconds > 59) {
              isSecond = (p.inSeconds / 60).floor();
            } else {
              isSecond = p.inSeconds;
            }
          } else {
            if ((p.inSeconds / 60).floor() > isSecond) {
              if (p.inSeconds > 59) {
                isSecond = (p.inSeconds / 60).floor();
              } else {
                isSecond = p.inSeconds;
              }
            }
          }
        });
      });
      print('go to success');
      setState(() {
        process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 223;
        const timeout = const Duration(seconds: 1);
        _timer = Timer.periodic(timeout, (timer) {
          if (process >= 223) {
            process = 223;
          } else {
            if (isSecond == 60) {
              isSecond = 0;
              setState(() {
                isMin++;
              });
            }
            process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 223;
            if (isMin * 60 + isSecond <= allMin * 60 + allSecond - 1) {
              print('${isSecond}');
              setState(() {
                isSecond++;
              });
            }
          }
        });
      });
      // await audioPlayer.resume();
    } else {
      print('go to failed');
    }
  }
  jumpDirection(select) async{
    int result = await audioPlayer.seek(new Duration(milliseconds: jumpTime));
    if (result == 1) {
      jump(select);
      print('go to success');
      // await audioPlayer.resume();
    } else {
      print('go to failed');
    }
  }
  @override
  void initState() {
    void getRenderInfo() async{
      List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
      var bookId = '';
      for (var i in cookies) {
        if (i.name == 'select_book') {
          bookId = i.value;
        }
      }
      var res = await HttpUtils.request(
        '/get_audio_book_info?b_id=$bookId&a_id=a_0001&r_id=${cookies[0].value}',
        method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
      setState(() {
        allMin = (result.data['audio'][0]['duration'] / 1000 / 60).floor();
        allSecond = (result.data['audio'][0]['duration'] / 1000 - allMin * 60).floor();
        audioUrl = (result.data['audio'][0]['audio_url']);
        audioBookData.add(AudioBookData.fromJSON(result.data));
        renderObject = result.data;
        chapterList = result.data['chapter_collection'];
      });
    }
    void test() async{
      var res = await HttpUtils.request(
          '/get_audio_book_data',
          method: HttpUtils.GET
      );
      var result = DataTransfer.fromJSON(res);
      print(result);
    }
    // test();
    getRenderInfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // int wordNum = audioBookData[0].rawWord.length;
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black),
            ),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFFFFFBEB) : Color(0xFFCFECDD)),
                    padding: EdgeInsets.symmetric(horizontal: 27,vertical: 64),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 36,
                            padding: EdgeInsets.symmetric(vertical: 11),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('${isMin < 10 ? '0${isMin}' : isMin}:${isSecond < 10 ? '0${isSecond}' : isSecond}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37))),
                                SizedBox(width: 10),
                                Container(
                                  width: 223,
                                  height: 1,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 223,
                                        height: 1,
                                        decoration: BoxDecoration(color: Color(0xFFF0F0F0)),
                                      ),
                                      Container(
                                        width: process,
                                        height: 1,
                                        decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37)),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text('${allMin < 10 ? '0${allMin}' : isMin}:${allSecond < 10 ? '0${allSecond}' : allSecond}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37))),
                              ],
                            )
                          ),
                          Container(
                            width: 321,
                            height: MediaQuery.of(context).size.height - 36,
                            child: ListView.builder(
                              itemCount: audioBookData[0].sentences.length + 4,
                              itemBuilder: (BuildContext context, int index){
                                if (index == 0) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('Day ${audioBookData[0].day < 10 ? 0 : ''}${audioBookData[0].day}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: fontSizeSet['title'], fontWeight: FontWeight.w600, fontFamily: 'NewYork')),
                                        SizedBox(height: 27)
                                      ],
                                    ),
                                  );
                                } else if (index == 1) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 321,
                                          padding: EdgeInsets.all(18),
                                          decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFFFEECC8) : Color(0xFFE4F9EE), borderRadius: BorderRadius.all(Radius.circular(4))),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text('今日词表', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: fontSizeSet['vocabulary'], fontWeight: FontWeight.w600)),
                                                  Text('查看释义', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: fontSizeSet['explain'], fontWeight: FontWeight.w500))
                                                ],
                                              ),
                                              SizedBox(height: 18),
                                              Text('${audioBookData[0].rawWord}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: fontSizeSet['rawWord'], height: 1.5))
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 36),
                                      ],
                                    ),
                                  );
                                } else if (index == 2) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 148,
                                                child: VerticalDivider(
                                                  thickness: 1,
                                                  color: Color(0xFFDCDCDC),
                                                ),
                                              ),
                                              SizedBox(width: 15),
                                              Container(
                                                width: 290,
                                                child: Text('${audioBookData[0].previousStory}', style: TextStyle(color: Color(0xFF787878), fontSize: fontSizeSet['story'], height: 2)),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 36),
                                      ],
                                    ),
                                  );
                                } else if (index == audioBookData[0].sentences.length + 3) {
                                  return Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 12),
                                        GestureDetector(
                                          onTap: ()async{
                                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                            bool flag = true;
                                            for (var i in cookies) {
                                              if (i.name == 'articleId') {
                                                i.value = selectArticle;
                                                flag = false;
                                              }
                                            }
                                            if (flag) {
                                              cookies.add(new Cookie('articleId', selectArticle));
                                            }
                                            (await Api.cookieJar).saveFromResponse(Uri.parse('http://localhost:3000/login'), cookies);
                                            Navigator.pushNamed(context, '/question');
                                          },
                                          child: Container(
                                            width: 339,
                                            height: 43,
                                            decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(28))),
                                            child: Center(
                                              child: Text('读完了，去做题', style: TextStyle(color: Colors.white, fontSize: fontSizeSet['question'], fontWeight: FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 160)
                                      ],
                                    ),
                                  );
                                } else if (selectId == index) {
                                  return paragraph(sentence: '${audioBookData[0].sentences[index - 3]}', color: Color(0xFF3C3C3C), selectColor: theme == 'brown' ? Color(0xFFEAD2A4) : Color(0xFF00B4AA), clickAble: false, func: (key) => setClickAble(key), index: index, refresh: clickAble ? true : false, fontSizeSet: fontSizeSet['article']);
                                } else {
                                  // keys.add(GlobalKey(debugLabel:index.toString()));
                                  return paragraph(sentence: '${audioBookData[0].sentences[index - 3]}', color: Color(0xFF3C3C3C), selectColor: theme == 'brown' ? Color(0xFFEAD2A4) : Color(0xFF00B4AA), clickAble: true, func: (key) => setClickAble(key), showModal: (height) => setModal(height), index: index, refresh: false, fontSizeSet: fontSizeSet['article']);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 43,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 76,
                    padding: EdgeInsets.symmetric(horizontal: 74),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: ()async {
                                pause();
                                setState(() {
                                  isMin = 0;
                                  isSecond = 0;
                                  jumpTime = 0;
                                  isPlay = true;
                                });
                                jumpDirection(false);
                              },
                              child: Container(
                                width: 43,
                                height: 43,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                child: Center(
                                  child: Image.asset('images/icon_backone.png', width: 27, height: 27),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isPlay = !isPlay;
                                  if (isPlay && process <=223) {
                                    if (isMin > 0 || isSecond > 0) {
                                      jump(false);
                                    } else {
                                      play();
                                    }
                                  } else {
                                    pause();
                                  }
                                });
                              },
                              child: AnimatedContainer(
                                width: 67,
                                height: 67,
                                duration: Duration(milliseconds: 500),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(34)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                child: Center(
                                  child: Image.asset(isPlay ? 'images/icon_pause_brown.png' : 'images/icon_brown_play.png', width: 27, height: 27),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                changeOpacity();
                              },
                              child: Container(
                                width: 43,
                                height: 43,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                child: Center(
                                  child: Image.asset('images/icon_console.png', width: 27, height: 27),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  ),
                ),
                Positioned(
                  bottom: 126,
                  height: 200,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(horizontal: 74),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          opacity: opacityLevel,
                          duration: new Duration(seconds: 1),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if (fontSizeSet['theme'] == 'medium') {
                                    setState(() {
                                      fontSizeSet = {
                                        'theme': 'large',
                                        'title': 36.0,
                                        'vocabulary': 18.0,
                                        'explain': 14.5,
                                        'rawWord': 18.0,
                                        'story': 14.5,
                                        'question': 18.0,
                                        'articleNum': 16.5,
                                        'note': 18.0,
                                        'article': 20.0
                                      };
                                    });
                                  } else if (fontSizeSet['theme'] == 'large') {
                                    setState(() {
                                      fontSizeSet = {
                                        'theme': 'small',
                                        'title': 32.0,
                                        'vocabulary': 14.0,
                                        'explain': 11.5,
                                        'rawWord': 14.0,
                                        'story': 11.5,
                                        'question': 14.0,
                                        'articleNum': 13.5,
                                        'note': 14.0,
                                        'article': 16.0
                                      };
                                    });
                                  } else {
                                    setState(() {
                                      fontSizeSet = {
                                        'theme': 'medium',
                                        'title': 34.0,
                                        'vocabulary': 16.0,
                                        'explain': 13.0,
                                        'rawWord': 16.0,
                                        'story': 13.0,
                                        'question': 16.0,
                                        'articleNum': 15.0,
                                        'note': 16.0,
                                        'article': 18.0
                                      };
                                    });
                                  }
                                },
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                  child: Center(
                                    child: Image.asset('images/icon_font.png', width: 27, height: 27),
                                  ),
                                ),
                              ),
                              Container(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: chapterList.map((item){
                                      return (
                                          GestureDetector(
                                            onTap: ()async{
                                              int re = await audioPlayer.release();
                                              if (re == 1) {
                                                setState(() {
                                                  isMin = 0;
                                                  isSecond = 0;
                                                  selectArticle = 'a_00${int.parse(item) > 10 ? '' : '0'}$item';
                                                });
                                                var res = await HttpUtils.request(
                                                    '/get_audio_book_info?b_id=b_0001&a_id=a_00${int.parse(item) > 10 ? '' : '0'}$item',
                                                    method: HttpUtils.GET
                                                );
                                                var result = DataTransfer.fromJSON(res);
                                                setState(() {
                                                  allMin = (result.data['audio'][0]['duration'] / 1000 / 60).floor();
                                                  allSecond = (result.data['audio'][0]['duration'] / 1000 - allMin * 60).floor();
                                                  audioUrl = (result.data['audio'][0]['audio_url']);
                                                  audioBookData = [];
                                                  audioBookData.add(AudioBookData.fromJSON(result.data));
                                                  renderObject = result.data;
                                                  chapterList = result.data['chapter_collection'];
                                                });
                                                print('release success');
                                              } else {
                                                print('release failed');
                                              }
                                            },
                                            child: Container(
                                              width: 43,
                                              height: 43,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                              child: Center(
                                                child: Text('day $item', style: TextStyle(color: Colors.black, fontSize: fontSizeSet['articleNum'], fontFamily: 'NewYork')),
                                              ),
                                            ),
                                          )
                                      );
                                    }).toList()
                                  ),
                                )
                              ),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    if (theme == 'brown') {
                                      theme = 'green';
                                    } else {
                                      theme = 'brown';
                                    }
                                  });
                                },
                                child: Container(
                                  width: 43,
                                  height: 43,
                                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                  child: Center(
                                    child: Image.asset('images/icon_theme.png', width: 27, height: 27),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      textController = TextEditingController.fromValue(
                        ///用来设置初始化时显示
                        TextEditingValue(
                          ///用来设置文本 controller.text = "0000"
                            text: '',
                            ///设置光标的位置
                            selection: TextSelection.fromPosition(
                              ///用来设置文本的位置
                                TextPosition(
                                    affinity: TextAffinity.downstream,
                                    /// 光标向后移动的长度
                                    offset: 0))),
                      );
                      clickAble = true;
                      editModal = false;
                    });
                  },
                  child: Offstage(
                    offstage: clickAble,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          color: Color(0x4D000000),
                        ),
                        Positioned(
                          top: modalHeight < 360 ? modalHeight + 80 : modalHeight - 340,
                          left:  MediaQuery.of(context).size.width / 2 - 180,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Offstage(
                                offstage: !hasNote,
                                child: Container(
                                  width: 321,
                                  padding: EdgeInsets.symmetric(vertical: 13, horizontal: 18),
                                  decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFFFEECC8) : Color(0xFFE4F9EE), borderRadius: BorderRadius.all(Radius.circular(9)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('笔记', style: TextStyle(color: Color(0xFF282828), fontSize: fontSizeSet['note'], fontWeight: FontWeight.w600)),
                                          GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                editModal = true;
                                              });
                                            },
                                            child: Image.asset('images/icon_more.png', width: 25, height: 25),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 7),
                                      Divider(),
                                      SizedBox(height: 17),
                                      Text('$isNote', style: TextStyle(color: Color(0xFF3C3C3C)))
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 18),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    clickAble = false;
                                  });
                                },
                                child: Container(
                                  height: 76,
                                  decoration: BoxDecoration(color: Color(0xFF3C3C3C), borderRadius: BorderRadius.all(Radius.circular(20))),
                                  padding: EdgeInsets.symmetric(horizontal: 27, vertical: 13),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: ()async{
                                          setState(() {
                                            isPlay = true;
                                          });
                                          pause();
                                          jumpDirection(true);
                                        },
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('images/icon_playArticle.png', width: 25, height: 25),
                                              SizedBox(height: 3),
                                              Text('播放', style: TextStyle(color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 36),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('images/icon_underline.png', width: 25, height: 25),
                                            SizedBox(height: 3),
                                            Text('划线', style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 36),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            createModal = !createModal;
                                          });
                                        },
                                        child: Container(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Image.asset('images/icon_write.png', width: 25, height: 25),
                                              SizedBox(height: 3),
                                              Text('笔记', style: TextStyle(color: Colors.white))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 36),
                                      Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Image.asset('images/icon_shareArticle.png', width: 25, height: 25),
                                            SizedBox(height: 3),
                                            Text('分享', style: TextStyle(color: Colors.white))
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            child: Offstage(
                              offstage: !editModal,
                              child: GestureDetector(
                                onTap: (){
                                  setState(() {
                                    clickAble = false;
                                  });
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 210,
                                  decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFFFFFBEB) : Color(0xFFCFECDD), borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            createModal = true;
                                            editModal = false;
                                            newNote = isNote;
                                            print(newNote);
                                          });
                                          textController = TextEditingController.fromValue(
                                            ///用来设置初始化时显示
                                            TextEditingValue(
                                              ///用来设置文本 controller.text = "0000"
                                              text: isNote,
                                              ///设置光标的位置
                                              selection: TextSelection.fromPosition(
                                                ///用来设置文本的位置
                                                TextPosition(
                                                    affinity: TextAffinity.downstream,
                                                    /// 光标向后移动的长度
                                                    offset: isNote.length))),
                                          );
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(17),
                                          child:  Center(
                                            child: Text('编辑', style: TextStyle(color: Color(0xFF282828))),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(17),
                                          child:  Center(
                                            child: Text('删除', style: TextStyle(color: Color(0xFF282828))),
                                          ),
                                        ),
                                      ),
                                      Divider(),
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            editModal = false;
                                          });
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          padding: EdgeInsets.all(17),
                                          child:  Center(
                                            child: Text('取消', style: TextStyle(color: Color(0xFF282828))),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                        Positioned(
                          bottom: 0,
                          child: Offstage(
                            offstage: !createModal,
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  clickAble = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 157,
                                padding: EdgeInsets.only(top: 9, right: 18, left: 18, bottom: 9),
                                decoration: BoxDecoration(color: Color(0xFFFEECC8), borderRadius: BorderRadius.only(topLeft: Radius.circular(9), topRight: Radius.circular(9))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      controller: textController,
                                      onChanged: (val){
                                        setState(() {
                                          newNote = val;
                                        });
                                      },
                                      maxLines: 4,
                                      showCursor: true,
                                      cursorWidth: 3,
                                      cursorRadius: Radius.circular(10),
                                      cursorColor: Color(0xFF00B4AA),
                                      keyboardType: TextInputType.multiline,
                                      textInputAction: TextInputAction.unspecified,
                                      decoration: InputDecoration(
                                        hintText: '写点什么吧...',
                                        border: InputBorder.none
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: ()async {
                                            List<Cookie> cookies = (await Api.cookieJar).loadForRequest(Uri.parse('http://localhost:3000/login'));
                                            var bookId = '';
                                            for (var i in cookies) {
                                              print(i.name);
                                              if (i.name == 'select_book') {
                                                bookId = i.value;
                                              }
                                            }
                                            var res = await HttpUtils.request(
                                              '/send_article_note',
                                              method: HttpUtils.POST,
                                              data: {
                                                'r_id': cookies[0].value,
                                                'a_id': selectArticle,
                                                'b_id': bookId,
                                                'pos': selectId - 3,
                                                'content': newNote
                                              }
                                            );
                                            var result = DataTransfer.fromJSON(res);
                                            if (result.status == 1) {
                                              setState(() {
                                                createModal = false;
                                              });
                                            }
                                          },
                                          child: Text('保存', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontWeight: FontWeight.w600)),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
