import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/recommend/RecommendTab.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RecommendTab(),
      ),
    );
  }
}
