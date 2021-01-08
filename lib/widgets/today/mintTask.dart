import 'package:flutter/material.dart';
import 'package:audio_book_app/tools/TaskStatus.dart';
import 'package:audio_book_app/widgets/today/taskCoin.dart';

class MintTask extends StatefulWidget {
  @override
  _MintTaskState createState() => _MintTaskState();
}

class _MintTaskState extends State<MintTask> {
  int count = 0;
  List <TaskStatus> tasksList = [
    TaskStatus.fromJSON({
      'status': [1, -1, 2, 0, 0, 0, 0, 0, 0, 0]
    })
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50, left: 18, right: 18),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('正确率挑战任务', style: TextStyle(color: Color(0xFF282828), fontSize: 22, fontWeight: FontWeight.w500)),
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Image.asset('images/icon_close.png', width: 25, height: 25),
                )
              ],
            ),
            SizedBox(height: 5),
            Text('女性成长系列', style: TextStyle(color: Color(0xFF646464), fontSize: 16, fontWeight: FontWeight.w600)),
            SizedBox(height: 18),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('已获得', style: TextStyle(color: Color(0xFF282828), fontSize: 13, fontWeight: FontWeight.w600)),
                SizedBox(width: 6),
                Image.asset('images/goldCoin.png', width: 24, height: 24),
                SizedBox(width: 8),
                Text('9', style: TextStyle(color: Color(0xFFF7BE27), fontWeight: FontWeight.w600))
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            SizedBox(height: 36),
            Wrap(
              spacing: 37,
              runSpacing: 18,
              children: tasksList[0].status.map((item) {
                setState(() {
                  count++;
                });
                return TaskCoin(status: item, week: count);
              }).toList(),
            )
          ],
        ),
      )
    );
  }
}
