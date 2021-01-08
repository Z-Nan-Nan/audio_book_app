import 'package:flutter/material.dart';

class TaskCoin extends StatefulWidget {
  TaskCoin({Key key, this.status, this.week}):super(key:key);
  final int status;
  final int week;
  @override
  _TaskCoinState createState() => _TaskCoinState();
}

class _TaskCoinState extends State<TaskCoin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      width: 60,
      child: Stack(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Container(
                  width: 50,
                  height: 50,
                  child: Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            image: DecorationImage(
                                image: widget.status == -1 ? AssetImage('images/goldenmint_finish.png') : AssetImage('images/goldCoin.png'), fit: BoxFit.cover
                            )
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: widget.status == 0 ? Color(0xAAFFFFFF) : Colors.transparent
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: 50,
                  height: 18,
                  child: Stack(
                    children: [
                      Container(
                        width: 50,
                        height: 18,
                        child: Center(
                          child: Text('第${widget.week}周', style: TextStyle(color: Color(0xFF282828), fontSize: 13, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 18,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: widget.status == 0 ? Color(0xAAFFFFFF) : Colors.transparent
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              widget.status == 1 ? Image.asset('images/icon_done.png', width: 27, height: 27) : widget.status == 2 ? Image.asset('images/icon_now.png', width: 27, height: 27) : widget.status == -1 ? Image.asset('images/icon_fail.png', width: 27, height: 27) : Container()
            ],
          )
        ],
      ),
    );
  }
}
