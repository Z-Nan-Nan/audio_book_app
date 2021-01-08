class Course {
  final String chapterLabel;
  final bool isDone;
  final String bookName;
  final String termName;
  final String cover;
  Course({ this.chapterLabel, this.isDone, this.bookName, this.termName, this.cover });

  factory Course.fromJSON(Map<String, dynamic> json) {
    return Course(
        chapterLabel: json['chapterLabel'],
        isDone: json['isDone'],
        bookName: json['bookName'],
        termName: json['termName'],
        cover: json['cover']
    );
  }
}