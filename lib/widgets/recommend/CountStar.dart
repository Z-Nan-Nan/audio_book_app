import 'package:flutter/material.dart';

class CountStar extends StatefulWidget {
  CountStar({Key key, this.star, this.starColor}) :super(key: key);
  double star;
  String starColor;
  @override
  _CountStarState createState() => _CountStarState();
}

class _CountStarState extends State<CountStar> {
  @override

  Widget buildGrid() {
    List<Widget> tiles = [];
    Widget content;
    switch (widget.starColor) {
      case 'gold':
        for (var i = 0; i < widget.star; i++) {
          if (widget.star - i > 0 && widget.star - i < 1) {
            tiles.add(
                new Row(
                  children: [
                    Image.asset('images/halfStar_gold.png', width: 11, height: 11),
                    SizedBox(width: 2)
                  ],
                )
            );
          } else {
            tiles.add(
                new Row(
                  children: [
                    Image.asset('images/star_gold.png', width: 11, height: 11),
                    SizedBox(width: 2)
                  ],
                )
            );
          }
        }
        break;
      case 'green':
        for (var i = 0; i < widget.star; i++) {
          if (widget.star - i > 0 && widget.star - i < 1) {
            tiles.add(
                new Row(
                  children: [
                    Image.asset('images/halfStar.png', width: 11, height: 11),
                    SizedBox(width: 2)
                  ],
                )
            );
          } else {
            tiles.add(
                new Row(
                  children: [
                    Image.asset('images/star.png', width: 11, height: 11),
                    SizedBox(width: 2)
                  ],
                )
            );
          }
        }
        break;
    }
    content = new Row(
      children: tiles,
    );
    return content;
  }

  Widget build(BuildContext context) {
    return Container(
      child: buildGrid(),
    );
  }
}
