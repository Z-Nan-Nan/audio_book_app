import 'package:flutter/material.dart';
class ReadingTag extends StatefulWidget {
  ReadingTag({Key key, this.words}) :super(key: key);
  final String words;
  @override
  _ReadingTagState createState() => _ReadingTagState();
}

class _ReadingTagState extends State<ReadingTag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 20,
      decoration: BoxDecoration(color: Color(0x99000000), borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(widget.words, style: TextStyle(color: Colors.white, fontSize: 12),)
        ],
      ),
    );
  }
}
