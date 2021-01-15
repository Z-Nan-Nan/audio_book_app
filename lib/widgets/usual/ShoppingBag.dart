import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/recommend/ListData_test.dart';


class ShoppingBag extends StatefulWidget {
  @override
  _ShoppingBagState createState() => _ShoppingBagState();
}

class _ShoppingBagState extends State<ShoppingBag> {
  List <Books> booksList = [];
  bool chooseAll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('已选书单'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          FlatButton(
            height: 28,
            minWidth: 28,
            child: Text('管理', style: TextStyle(color: Color(0xFF282828), fontSize: 16),),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        color: Color(0xFFFFFFFF),
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                width: 375,
                height: 710,
                color: Color(0xFFFFFFFF),
                child: Column(
                  children: booksList.map((item){
                    return Offstage(
                      offstage: !item.buy,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  FlatButton(
                                    height: 28,
                                    minWidth: 28,
                                    shape: CircleBorder(),
                                    child: item.pay ? Image.asset('images/icon_right_green.png', width: 28, height: 28) : Image.asset('images/icon_circle_green.png', width: 28, height: 28),
                                    onPressed: (){
                                      setState(() {
                                        item.pay = !item.pay;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(item.images, width: 86, height: 148)
                                ],
                              ),
                              SizedBox(width: 22),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(item.title, style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w700),),
                                        SizedBox(height: 6),
                                        Text(item.date, style: TextStyle(color: Color(0xFF646464), fontWeight: FontWeight.w400, fontSize: 14),),
                                        SizedBox(height: 14),
                                        Text('￥${item.cost}', style: TextStyle(color: Color(0xFFFF6E0A), fontSize: 18, fontWeight: FontWeight.w600),),
                                        SizedBox(height: 12),
                                        Container(
                                          width: 101,
                                          height: 20,
                                          color: Color(0x80FF6E0A),
                                          padding: EdgeInsets.all(2),
                                          child: Text('续报优惠已减¥20', style: TextStyle(color: Colors.white, fontSize: 12),),
                                        )
                                      ]
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                width: 375,
                child: Column(
                  children: [
                    Divider(),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            padding: EdgeInsets.only(left: 8, top: 3, right: 4, bottom: 3),
                            child: Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 156,
                                      height: 24,
                                      padding: EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xFFFF9953),
                                              width: 1,
                                              style: BorderStyle.solid
                                          )
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset('images/icon_select.png', width: 10, height: 10),
                                          Text('老用户涨价补贴已减¥50', style: TextStyle(color: Color(0xFFFF9953), fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 150),
                                        FlatButton(
                                          child: Image.asset('images/icon_toUp.png'),
                                          minWidth: 20,
                                          height: 20,
                                          onPressed: (){

                                          },
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Container(
                            child: Row(
                              children: [
                                FlatButton(
                                  height: 28,
                                  minWidth: 28,
                                  shape: CircleBorder(),
                                  child: chooseAll ? Image.asset('images/icon_right_green.png', width: 28, height: 28) : Image.asset('images/icon_circle_green.png', width: 28, height: 28),
                                  onPressed: (){
                                    setState(() {
                                      chooseAll = !chooseAll;
                                      booksList.map((item){
                                        if (item.buy == true) {
                                          item.pay = chooseAll;
                                        }
                                      }).toList();
                                    });
                                  },
                                ),
                                SizedBox(width: 1),
                                Text('全选', style: TextStyle(color: Color(0xFF646464), fontSize: 14),),
                                SizedBox(width: 40),
                                Container(
                                  width: 120,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('原价￥458', style: TextStyle(decoration: TextDecoration.lineThrough, color: Color(0xFFA0A0A0), fontSize: 12),),
                                          Text('￥358', style: TextStyle(color: Color(0xFFFF6E0A), fontSize: 20),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Text('共计优惠¥100', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12),),
                                          SizedBox(width: 3)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                FlatButton(
                                  minWidth: 106,
                                  height: 40,
                                  color: Color(0xFF00B4AA),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(28))
                                  ),
                                  child: Text('去结算', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),),
                                  onPressed: (){
                                    print(1);
                                  },
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
