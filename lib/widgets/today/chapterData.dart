class Chapter {
  final int progress;
  final String title;
  final String term;
  final String cover;
  bool isDone;

  Chapter({this.progress, this.title, this.term, this.cover});

  Chapter.fromJSON(Map<String, dynamic> data):
      progress = data['progress'],
      title = data['title'],
      term = data['term'],
      cover= data['cover'],
      isDone = data['isDone'];
}

List<dynamic> chapterData = [
  {
    'progress': 15,
    'title': 'One Day',
    'term': '第1期',
    'cover': 'http://ali.baicizhan.com/readin/images/2020081311083151.jpeg',
    'isDone': false
  },
  {
    'progress': 41,
    'title': '你当像鸟飞往你的山',
    'term': '第2期',
    'cover': 'http://ali.baicizhan.com/readin/images/2020060517233085.jpeg',
    'isDone': false
  },
  {
    'progress': 7,
    'title': '莎士比亚系列：第十二夜',
    'term': '第3期',
    'cover': 'http://ali.baicizhan.com/readin/images/2020051117451690.jpg',
    'isDone': false
  },
  {
    'progress': 22,
    'title': '弗兰肯斯坦',
    'term': '第4期',
    'cover': 'http://ali.baicizhan.com/readin/images/202004281128356.jpeg',
    'isDone': false
  }
];

List<Chapter> booksList = chapterData.map((item) => Chapter.fromJSON(item)).toList();
