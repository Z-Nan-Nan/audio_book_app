import 'package:flutter/material.dart';
import 'CommentData_test.dart';
import 'CountStar.dart';


class CommentList extends StatefulWidget {
  CommentList({Key key, this.list}) : super (key: key);
  List list;
  @override
  _CommentListState createState() => _CommentListState();
}

class _CommentListState extends State<CommentList> {
  List <Comment> comments = [];
  @override
  void initState() {
    for (var item in widget.list) {
      setState(() {
        comments.add(Comment.fromJSON(item));
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('热门读后感', style: TextStyle(color: Color(0xFF282828), fontSize: 16, fontWeight: FontWeight.w600),),
        SizedBox(height: 10),
        Column(
          children: comments.map((item){
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue,
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 12),
                        Text(item.name),
                        SizedBox(height: 12),
                        CountStar(star: item.star, starColor: 'green',)
                        // Image.asset('images/star.png', width: 11, height: 11)
                      ],
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('${item.like}', style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 12)),
                            SizedBox(width: 2),
                            GestureDetector(
                              child: item.isLike ? Image.asset('images/isLike.png', width: 17, height: 19,) : Image.asset('images/unlike.png', width: 17, height: 19),
                              onTap: (){
                                setState(() {
                                  item.isLike = !item.isLike;
                                  if (item.isLike) {
                                    item.like++;
                                  } else {
                                    item.like--;
                                  }
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(width: 52),
                    Container(
                      width: 274,
                      child: Text(item.text, style: TextStyle(color: Color(0xFF282828), height: 2),),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Divider(
                  indent: 20,
                  endIndent: 20,
                )
              ],
            );
          }).toList(),
        )
      ],
    );
  }
}
