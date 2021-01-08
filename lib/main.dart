import 'package:flutter/material.dart';
import 'package:audio_book_app/commons/route_manager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        splashColor: Colors.transparent,
        primaryColor: Color(0xFF00B4AA),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MintRouter.generateRoute,
    );
  }
}
