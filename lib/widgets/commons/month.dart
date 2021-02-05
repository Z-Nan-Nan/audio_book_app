import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/commons/day.dart';

class Month extends StatefulWidget {
  Month({Key key, this.year, this.nowMonth, this.pos, this.daysMap, this.startDay}):super(key:key);
  final int nowMonth;
  final int startDay;
  final int pos;
  final List daysMap;
  int year;
  @override
  _MonthState createState() => _MonthState();
}

class _MonthState extends State<Month> {
  @override
  Widget build(BuildContext context) {
    var count = 0;
    if (widget.startDay != 7) {
      print(widget.startDay);
      for (var i = 0; i < widget.startDay - 1; i++) {
        widget.daysMap.insert(0, {'read': -1});
      }
    } else {
      for (var i = 0; i < 6; i++) {
        widget.daysMap.insert(0, {'read': -1});
      }
    }
    return Container(
      width: 375,
      padding: EdgeInsets.all(7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('${widget.year}年${widget.nowMonth}月', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w700))
            ],
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 18,
            runSpacing: 22,
            children: widget.daysMap.map((day) {
              if (day['read'] > -1) {
                count++;
              }
              return Day(date: count, status: day['read'], nowMonth: widget.nowMonth,);
            }).toList()
          )
        ],
      ),
    );
  }
}
