import 'package:flutter/material.dart';

class paragraph extends StatefulWidget {
  paragraph({Key key, this.sentence, this.color, this.selectColor, this.clickAble, this.func, this.showModal, this.index, this.refresh, this.fontSizeSet}):super(key: key);
  final String sentence;
  final Color color;
  final Color selectColor;
  final int index;
  final func;
  final showModal;
  double fontSizeSet;
  bool refresh;
  bool clickAble;
  @override
  _paragraphState createState() => _paragraphState();
}

class _paragraphState extends State<paragraph> {
  bool isSelect = false;
  @override
  Widget build(BuildContext context) {
    if (widget.clickAble) {
      widget.refresh = !widget.refresh;
    }
    return GestureDetector(
      onPanDown: (detail){
        widget.showModal(detail.globalPosition.dy);
      },
      onTap: (){
        setState(() {
          isSelect = true;
        });
        widget.func(widget.index);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('${widget.sentence}', style: TextStyle(color: widget.refresh ? widget.color : isSelect ? widget.selectColor : widget.color, fontSize: widget.fontSizeSet, fontFamily: 'Charter', height: 2)),
      ),
    );
  }
}
