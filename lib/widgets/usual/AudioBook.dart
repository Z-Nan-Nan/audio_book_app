import 'dart:convert';
import 'dart:async';
import 'package:audio_book_app/tools/AudioBookData.dart';
import 'package:audio_book_app/widgets/commons/paragraph.dart';
import 'package:flutter/material.dart';

class AudioBook extends StatefulWidget {
  @override
  _AudioBookState createState() => _AudioBookState();
}

class _AudioBookState extends State<AudioBook> {
  List<AudioBookData> audioBookData = [
    AudioBookData.fromJSON({
      'day': 'Day 01',
      'raw_word': 'memorable / dump / sniffed / broadens / elbow / shallow / quaint / reassuring / perpetually / paisley',
      'previous_story': '大学毕业前一晚，平凡聪慧的Emma与花花公子Dexter相遇。这次短暂的邂逅深深印入彼此心中最柔软的部分，并将两人紧紧地系在一起。二十年的知与爱，定格在每年7月15日这一天的相遇与错过。当两人站在追逐的尽头，面对的到底是美满的结局还是无法挽回的遗憾？',
      'sentences': ['Part 1',
      '1988–1992',
      'Early Twenties',
      '‘That was a memorable day to me, for it made great changes in me. But, it is the same with any life. Imagine one selected day struck out of it and think how different its course would have been.',
      '‘Pause, you who read this, and think for a long moment of the long chain of iron or gold, of thorns or flowers, that would never have bound you, but for the formation of the first link on that memorable day.’',
      'Charles Dickens, Great Expectations',
      'Chapter 1',
      'The Future',
      'FRIDAY 15 JULY 1988',
      'Rankeillor Street, Edinburgh',
      '‘I suppose the important thing is to make some sort of difference,’ she said. ‘You know, actually change something.’',
      '‘What, like “change the world”, you mean?’',
      '‘Not the whole entire world. Just the little bit around you.’',
      'They lay in silence for a moment, bodies curled around each other in the single bed, then both began to laugh in low, predawn voices. ‘Can’t believe I just said that,’ she groaned. ‘Sounds a bit corny, doesn’t it?’',
      '‘A bit corny.’',
      '‘I’m trying to be inspiring! I’m trying to lift your grubby soul for the great adventure that lies ahead of you.’ She turned to face him. ‘Not that you need it. I expect you’ve got your future nicely mapped out, ta very much. Probably got a little flow-chart somewhere or something.’',
      '‘Hardly.’',
      '‘So what’re you going to do then? What’s the great plan?’',
      '‘Well, my parents are going to pick up my stuff, dump it at theirs, then I’ll spend a couple of days in their flat in London, see some friends. Then France—’',
      '‘Very nice—’',
      '‘Then China maybe, see what that’s all about, then maybe onto India, travel around there for a bit—’',
      '‘Travelling,’ she sighed. ‘So predictable.’',
      '‘What’s wrong with travelling?’',
      '‘Avoiding reality more like.’',
      '‘I think reality is over-rated,’ he said in the hope that this might come across as dark and charismatic.',
      'She sniffed. ‘S’alright, I suppose, for those who can afford it. Why not just say “I’m going on holiday for two years”? It’s the same thing.’',
      '‘Because travel broadens the mind,’ he said, rising onto one elbow and kissing her.',
      '‘Oh I think you’re probably a bit too broad-minded as it is,’ she said, turning her face away, for the moment at least. They settled again on the pillow.',
      '‘Anyway, I didn’t mean what are you doing next month, I meant the future-future, when you’re, I don’t know . . .’',
      '‘Forty?’ He too seemed to be struggling with the concept. ‘Don’t know. Am I allowed to say “rich”?’',
      '‘Just so, so shallow.’',
      '‘Alright then, “famous”.’ He began to nuzzle at her neck. ‘Bit morbid, this, isn’t it?’',
      '‘It’s not morbid, it’s . . . exciting.’',
      '‘“Exciting!”’ He was imitating her voice now, her soft Yorkshire accent, trying to make her sound daft.',
      'She got this a lot, posh boys doing funny voices, as if there was something unusual and quaint about an accent, and not for the first time she felt a reassuring shiver of dislike for him.',
      'She shrugged herself away until her back was pressed against the cool of the wall.',
      '‘Yes, exciting. We’re meant to be excited, aren’t we? All those possibilities. It’s like the Vice-Chancellor said, “the doors of opportunity flung wide . . .”’',
      '‘“Yours are the names in tomorrow’s newspapers . . .”’',
      '‘Not very likely.’',
      '‘So, what, are you excited then?’',
      '‘Me? God no, I’m crapping myself.’',
      '‘Me too. Christ . . .’ He turned suddenly and reached for the cigarettes on the floor by the side of the bed, as if to steady his nerves. ‘Forty years old. Forty. Fucking hell.’',
      'Smiling at his anxiety, she decided to make it worse. ‘So what’ll you be doing when you’re forty?’',
      'He lit his cigarette thoughtfully. ‘Well the thing is, Em—’',
      '‘“Em”? Who’s “Em”?’',
      '‘People call you Em. I’ve heard them.’',
      '‘Yeah, friends call me Em.’',
      '‘So can I call you Em?’',
      '‘Go on then, Dex.’',
      '‘So I’ve given this whole “growing old” thing some thought and I’ve come to the decision that I’d like to stay exactly as I am right now.’',
      'Dexter Mayhew. She peered up at him through her fringe as he leant against the cheap buttoned vinyl headboard and even without her spectacles on it was clear why he might want to stay exactly this way.',
      'Eyes closed, the cigarette glued languidly to his lower lip, the dawn light warming the side of his face through the red filter of the curtains, he had the knack of looking perpetually posed for a photograph.',
      'Emma Morley thought ‘handsome’ a silly, nineteenth-century word, but there really was no other word for it, except perhaps ‘beautiful’.',
      'He had one of those faces where you were aware of the bones beneath the skin, as if even his bare skull would be attractive.',
      'A fine nose, slightly shiny with grease, and dark skin beneath the eyes that looked almost bruised, a badge of honour from all the smoking and late nights spent deliberately losing at strip poker with girls from Bedales.',
      'There was something feline about him: eyebrows fine, mouth pouty in a self-conscious way, lips a shade too dark and full, but dry and chapped now, and rouged with Bulgarian red wine.',
      'Gratifyingly his hair was terrible, short at the back and sides, but with an awful little quiff at the front. Whatever gel he used had worn off, and now the quiff looked pert and fluffy, like a silly little hat.',
      'Still with his eyes closed, he exhaled smoke through his nose. Clearly he knew he was being looked at because he tucked one hand beneath his armpit, bunching up his pectorals and biceps.',
      'Where did the muscles come from? Certainly not sporting activity, unless you counted skinny-dipping and playing pool. Probably it was just the kind of good health that was passed down in the family, along with the stocks and shares and the good furniture.',
      'Handsome then, or beautiful even, with his paisley boxer shorts pulled down to his hip bones and somehow here in her single bed in her tiny rented room at the end of four years of college.',
      '‘Handsome’! Who do you think you are, Jane Eyre? Grow up. Be sensible. Don’t get carried away.']
    })
  ];
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
  String theme = 'brown';
  changeOpacity() {
    setState(
      () => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0
    );
  }
  setClickAble(i) {
    setState(() {
      clickAble = false;
      selectId = i;
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
                                  width: 236,
                                  height: 1,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: 236,
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
                                        Text('${audioBookData[0].day}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: 34, fontWeight: FontWeight.w600, fontFamily: 'NewYork')),
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
                                          height: 154,
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
                                                  Text('今日词表', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: 16, fontWeight: FontWeight.w600)),
                                                  Text('查看释义', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: 13, fontWeight: FontWeight.w500))
                                                ],
                                              ),
                                              SizedBox(height: 18),
                                              Text('${audioBookData[0].rawWord}', style: TextStyle(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF2E4B37), fontSize: 16, height: 1.5))
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
                                                child: Text('${audioBookData[0].previousStory}', style: TextStyle(color: Color(0xFF787878), fontSize: 13, height: 2)),
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
                                          onTap: (){
                                            Navigator.pushNamed(context, '/question');
                                          },
                                          child: Container(
                                            width: 339,
                                            height: 43,
                                            decoration: BoxDecoration(color: theme == 'brown' ? Color(0xFF524832) : Color(0xFF01B4AB), borderRadius: BorderRadius.all(Radius.circular(28))),
                                            child: Center(
                                              child: Text('读完了，去做题', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 160)
                                      ],
                                    ),
                                  );
                                } else if (selectId == index) {
                                  return paragraph(sentence: '${audioBookData[0].sentences[index - 3]}', color: Color(0xFF3C3C3C), selectColor: theme == 'brown' ? Color(0xFFEAD2A4) : Color(0xFF00B4AA), clickAble: false, func: (key) => setClickAble(key), index: index, refresh: clickAble ? true : false);
                                } else {
                                  // keys.add(GlobalKey(debugLabel:index.toString()));
                                  return paragraph(sentence: '${audioBookData[0].sentences[index - 3]}', color: Color(0xFF3C3C3C), selectColor: theme == 'brown' ? Color(0xFFEAD2A4) : Color(0xFF00B4AA), clickAble: true, func: (key) => setClickAble(key), showModal: (height) => setModal(height), index: index, refresh: false);
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
                            Container(
                              width: 43,
                              height: 43,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                              child: Center(
                                child: Image.asset('images/icon_backone.png', width: 27, height: 27),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  isPlay = !isPlay;
                                  if (isPlay && process <=236) {
                                    process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 236;
                                    const timeout = const Duration(seconds: 1);
                                    _timer = Timer.periodic(timeout, (timer) {
                                      setState(() {
                                        if (process >= 236) {
                                          process = 236;
                                        } else {
                                          if (isSecond == 60) {
                                            isSecond = 0;
                                            isMin++;
                                          }
                                          process = (isMin * 60 + isSecond) / (allMin * 60 + allSecond) * 236;
                                          if (isMin * 60 + isSecond <= allMin * 60 + allSecond - 1) {
                                            print('${isSecond}');
                                            isSecond++;
                                          }
                                        }
                                      });
                                    });
                                  } else {
                                    setState(() {
                                      if (_timer != null) {
                                        _timer.cancel();
                                        _timer = null;
                                      }
                                    });
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 43,
                                height: 43,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                child: Center(
                                  child: Image.asset('images/icon_font.png', width: 27, height: 27),
                                ),
                              ),
                              Container(
                                width: 43,
                                height: 43,
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(22)), boxShadow: [BoxShadow(color: Color(0x33000000),offset: Offset(0.0, 9.0), blurRadius: 18.0, spreadRadius: 1.0)]),
                                child: Center(
                                  child: Text('1.0x', style: TextStyle(color: Colors.black, fontSize: 15, fontFamily: 'NewYork')),
                                ),
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
                                offstage: false,
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
                                          Text('笔记', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600)),
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
                                      Text('《东方快车谋杀案》（Murder on the Orient Express）是英国作家阿加莎·克里斯蒂创作的侦探小说', style: TextStyle(color: Color(0xFF3C3C3C)))
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
                                      Container(
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
                                            createModal = true;
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
