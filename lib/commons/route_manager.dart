import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:audio_book_app/routes/home/home.dart';
import 'package:audio_book_app/widgets/usual/ShoppingBag.dart';
import 'package:audio_book_app/widgets/recommend/CourseInfo.dart';
import 'package:audio_book_app/routes/not-found.dart';
import 'package:audio_book_app/widgets/recommend/Article.dart';
import 'package:audio_book_app/widgets/usual/BookShelf.dart';
import 'package:audio_book_app/widgets/usual/ReadingResult.dart';
import 'package:audio_book_app/widgets/usual/AudioBook.dart';
import 'package:audio_book_app/widgets/usual/question.dart';
import 'package:audio_book_app/widgets/usual/explain.dart';
import 'package:audio_book_app/widgets/usual/setting.dart';
import 'package:audio_book_app/widgets/usual/ShareBook.dart';
import 'package:audio_book_app/widgets/today/goldenMint.dart';
import 'package:audio_book_app/widgets/today/mintTask.dart';
import 'package:audio_book_app/widgets/usual/login.dart';
import 'package:audio_book_app/widgets/usual/sign.dart';
import 'package:audio_book_app/widgets/commons/ReadingNote.dart';

class RouteName {
  static const String home = '/home';
  static const String shoppingBag = '/shoppingBag';
  static const String courseInfo = '/courseInfo';
  static const String article = '/article';
  static const String bookshelf = '/bookshelf';
  static const String readingResult = '/readingResult';
  static const String audioBook = '/audioBook';
  static const String question = '/question';
  static const String explain = '/explain';
  static const String setting = '/setting';
  static const String shareBook = '/shareBook';
  static const String goldenMint = '/goldenMint';
  static const String mintTask = '/mintTask';
  static const String login = '/login';
  static const String sign = '/sign';
  static const String note = '/note';
}

class MintRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(builder: (_) => Home());
      case RouteName.shoppingBag:
        return MaterialPageRoute(builder: (_) => ShoppingBag());
      case RouteName.courseInfo:
        return MaterialPageRoute(builder: (_) => CourseInfo());
      case RouteName.article:
        return MaterialPageRoute(builder: (_) => Article());
      case RouteName.bookshelf:
        return MaterialPageRoute(builder: (_) => BookShelf());
      case RouteName.readingResult:
        return MaterialPageRoute(builder: (_) => ReadingResult());
      case RouteName.audioBook:
        return MaterialPageRoute(builder: (_) => AudioBook());
      case RouteName.question:
        return MaterialPageRoute(builder: (_) => Question());
      case RouteName.explain:
        return MaterialPageRoute(builder: (_) => Explain());
      case RouteName.setting:
        return MaterialPageRoute(builder: (_) => Setting());
      case RouteName.shareBook:
        return MaterialPageRoute(builder: (_) => ShareBook());
      case RouteName.goldenMint:
        return MaterialPageRoute(builder: (_) => GoldenMint());
      case RouteName.mintTask:
        return MaterialPageRoute(builder: (_) => MintTask());
      case RouteName.login:
        return MaterialPageRoute(builder: (_) => Login());
      case RouteName.sign:
        return MaterialPageRoute(builder: (_) => Sign());
      case RouteName.note:
        return MaterialPageRoute(builder: (_) => ReadingNote());
      default:
        return MaterialPageRoute(builder: (_) => Home());
    }
  }
}