import 'package:flutter/material.dart';

class Explain extends StatefulWidget {
  @override
  _ExplainState createState() => _ExplainState();
}

class _ExplainState extends State<Explain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 89, left: 18, right: 18),
        decoration: BoxDecoration(color: Color(0xFFFEECC8)),
      ),
    );
  }
}
