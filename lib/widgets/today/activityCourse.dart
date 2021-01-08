import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_book_app/widgets/commons/course.dart';
import 'package:audio_book_app/widgets/commons/book.dart';
import 'package:audio_book_app/widgets/today/bookDetails.dart';

class ActivityCourses extends StatefulWidget {
  final List<Course> courses;
  ActivityCourses({this.courses});

  @override
  State<StatefulWidget> createState() {
    return _ActivityCoursesState();
  }
}

class _ActivityCoursesState extends State<ActivityCourses> {
  CarouselController _largeCarouselController = CarouselController();
  CarouselController _smallCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CarouselSlider(
          items: widget.courses.map((course) => BookDetails(
            chapterLabel: course.chapterLabel,
            bookName: course.bookName,
            termName: course.termName,
            isDone: course.isDone,
            cover: course.cover,
          )).toList(),
          options: CarouselOptions(
              height: 297.0,
              enableInfiniteScroll: false,
              onPageChanged: (int page, _) {
                _smallCarouselController.animateToPage(page);
              }
          ),
          carouselController: _largeCarouselController,
        ),
        Padding(
          padding: EdgeInsets.only(top: 28.0, bottom: 60.0),
          child: CarouselSlider(
              items: widget.courses.asMap().entries.map((entry) => Book(
                height: 50.0,
                coverUrl: entry.value.cover,
                onTap: () {
                  _smallCarouselController.animateToPage(entry.key);
                },
              )).toList(),
              carouselController: _smallCarouselController,
              options: CarouselOptions(
                  height: 50.0,
                  viewportFraction: 0.18,
                  enableInfiniteScroll: false,
                  onPageChanged: (int index, _) {
                    _largeCarouselController.animateToPage(index);
                  }
              )
          ),
        ),
        // child: Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: widget.courses.asMap().entries.map((entry) => Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 10.0),
        //     child: Book(
        //       height: 50,
        //       coverUrl: entry.value.cover,
        //       onTap: () {
        //         _carouselController.animateToPage(entry.key);
        //       },
        //     ),
        //   )).toList(),
        // ),
      ],
    );
  }
}
