import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void noop() {}

class Book extends StatelessWidget {
  final double height;
  final Color background;
  final String coverUrl;
  final Function onTap;
  Book({ this.height, this.coverUrl, this.background = Colors.white, this.onTap = noop});

  Future<ui.Image> _loadNetworkImage(url) {
    ImageStream imageStream = NetworkImage(url).resolve(ImageConfiguration.empty);
    Completer<ui.Image> completer = Completer();
    ImageStreamListener listener = ImageStreamListener((ImageInfo frame, bool synchronousCall) {
      final ui.Image image = frame.image;
      completer.complete(image);
    });
    imageStream.addListener(listener);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([_loadNetworkImage(coverUrl), _loadNetworkImage('https://ali.bczcdn.com/mint-reading/img/book-box-shadow-r.94ae3770.png')]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return GestureDetector(
              onTap: onTap,
              child: CustomPaint(
                size: Size((143 / 190) * height, height),
                painter: _BookPainter( cover: snapshot.data[0], decorator: snapshot.data[1], background: background),
              ),
            );
          }
          return SizedBox.shrink();
        }
    );
  }
}

class _BookPainter extends CustomPainter {

  final ui.Image cover;
  final ui.Image decorator;
  final Color background;
  _BookPainter({ this.cover, this.decorator, this.background });


  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    double originalWidth = 142;
    double originalHeight = 190;
    double aspect = originalWidth / originalHeight;
    double backHeight = 183 / 190 * size.height.toDouble();
    double backWidth = aspect * backHeight;
    double backOffsetX = size.width - backWidth;
    double backOffsetY = (size.height - backHeight) / 2.0;
    double prevHeight = size.height;
    double prevWidth = 130 / 190 * prevHeight.toDouble();

    canvas.drawImageRect(
        cover,
        Rect.fromLTRB(0, 0, cover.width.toDouble(), cover.height.toDouble()),
        Rect.fromLTWH(backOffsetX, backOffsetY, backWidth, backHeight),
        paint
    );

    canvas.drawImageRect(
        cover,
        Rect.fromLTRB(0, 0, cover.width.toDouble(), cover.height.toDouble()),
        Rect.fromLTRB(0, 0, prevWidth, prevHeight),
        paint
    );

    canvas.drawImageRect(
        decorator,
        Rect.fromLTRB(0, 0, decorator.width.toDouble(), decorator.height.toDouble()),
        Rect.fromLTRB(0, 0, prevWidth, prevHeight),
        paint
    );

    paint.style = PaintingStyle.fill;
    paint.color = background;
    // 画前面封面的圆角
    canvas.drawDRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, prevWidth, prevHeight), Radius.circular(2.0)), RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, prevWidth, prevHeight), Radius.zero), paint);
    // 画背面封面的圆角
    canvas.drawDRRect(RRect.fromRectAndRadius(Rect.fromLTWH(backOffsetX, backOffsetY, backWidth, backHeight), Radius.circular(2.0)), RRect.fromRectAndRadius(Rect.fromLTWH(backOffsetX, backOffsetY, backWidth, backHeight), Radius.zero), paint);

    double thinkHeight = 174 / originalHeight * size.height;
    double thinkWidth = 9 / originalWidth * size.width;
    double thinkOffsetTop = (size.height - thinkHeight) / 2.0;
    paint.style = PaintingStyle.fill;
    paint.color = Color(0xFFD8D8D8);
    double thinkOffsetX = prevWidth;
    canvas.drawRect(Offset(thinkOffsetX, thinkOffsetTop) & Size(thinkWidth, thinkHeight), paint);

    paint.style = PaintingStyle.stroke;
    paint.color = Colors.white;
    for (int i = 1; i < thinkWidth; i++) {
      canvas.drawLine(Offset(thinkOffsetX + i, thinkOffsetTop), Offset(thinkOffsetX + i, thinkOffsetTop + thinkHeight), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}