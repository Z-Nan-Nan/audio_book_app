import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:audio_book_app/net/dio_manager.dart';
import 'package:audio_book_app/tools/DataTransfer.dart';


class DailyPictures extends StatefulWidget {
  @override
  _DailyPicturesState createState() => _DailyPicturesState();
}

class _DailyPicturesState extends State<DailyPictures> {

  List<String> sliders = [];

  @override
  void initState() {
    getTopPic ()async {
      var result = await HttpUtils.request(
          '/api_top_pic',
          method: HttpUtils.GET
      );
      var res = DataTransfer.fromJSON(result);
      for (var i in res.data['pic']) {
        setState(() {
          sliders.add(i['src']);
        });
      }
    }
    getTopPic();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.0,
      ),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 148.0,
          viewportFraction: 1.0,
        ),
        items: sliders.map((url) => Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).padding.left + 10.0,
            right: MediaQuery.of(context).padding.right + 10.0,
          ),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Image.network(url, fit: BoxFit.fill,)
          ),
        )).toList(),
      ),
    );
  }
}

