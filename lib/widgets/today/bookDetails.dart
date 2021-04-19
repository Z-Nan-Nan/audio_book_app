import 'package:flutter/cupertino.dart';
import 'package:audio_book_app/widgets/commons/book.dart';

class BookDetails extends StatelessWidget {
  final String chapterLabel;
  final bool isDone;
  final String bookName;
  final String termName;
  final String cover;

  BookDetails({ this.chapterLabel, this.isDone, this.bookName, this.termName, this.cover });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isDone ? Image.asset('images/select_right_green.png', width: 24.0, height: 24.0, fit: BoxFit.fill) : Image.asset('images/icon_undone.png', width: 24.0, height: 24.0, fit: BoxFit.fill,),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(chapterLabel, style: TextStyle(
                  fontFamily: 'NewYorkLarge',
                  fontSize: 15.0,
                  color: Color(0xFF646464)
              ),),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 19.0),
          child: Book(height: 192, coverUrl: cover,),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 13.0, bottom: 3.0),
          child: Text(bookName, style: TextStyle(
              fontSize: 22.0,
              color: Color(0xFF282828),
              height: 29 / 22.0
          ),),
        ),
        Text(termName, style: TextStyle(
            fontSize: 11.0,
            color: Color(0xFF646464),
            height: 15 / 11.0
        ),)
      ],
    );
  }
}