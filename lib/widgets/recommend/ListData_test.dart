class Books {
  final bool recommend;
  final String title;
  final String tag;
  final List lists;
  final String images;
  final String manager;
  final String date;
  final int avatar;
  final int cost;
  bool buy;
  bool pay;

  Books({this.recommend, this.title, this.tag, this.lists, this.images, this.manager, this.avatar, this.buy, this.pay, this.date, this.cost});

  Books.fromJSON(Map<String, dynamic> data):
        recommend = data['recommend'],
        title = data['title'],
        tag = data['tag'],
        lists = data['lists'],
        images = data['images'],
        manager = data['manager'],
        avatar = data['avatar'],
        buy = data['buy'],
        pay = data['pay'],
        date = data['date'],
        cost = data['cost'];
}

List<dynamic> ListData = [
  {
    'recommend': true,
    'title': '环球梦工厂系列',
    'tag': '成长/家庭故事/真善美',
    'lists': ['小王子'],
    'images': 'images/bookPic_1.png',
    'manager': 'Abc',
    'avatar': 0x9BCD9B,
    'buy': false,
    'pay': true,
    'date': '课程时间：3月28日-6月16日',
    'cost': 169
  },
  {
    'recommend': true,
    'title': '环球梦工厂系列',
    'tag': '成长/家庭故事/真善美',
    'lists': ['小王子', '纳尼亚传奇'],
    'images': 'images/bookPic_2.png',
    'manager': 'Bill',
    'avatar': 0xC0FF3E,
    'buy': false,
    'pay': true,
    'date': '课程时间：3月28日-6月16日',
    'cost': 170
  },
  {
    'recommend': false,
    'title': '环球梦工厂系列',
    'tag': '成长/家庭故事/真善美',
    'lists': ['小王子', '纳尼亚传奇', '傲慢与偏见'],
    'images': 'images/bookPic_3.png',
    'manager': 'Bill',
    'avatar': 0xCD853F,
    'buy': false,
    'pay': true,
    'date': '课程时间：3月28日-6月16日',
    'cost': 181
  },
  {
    'recommend': false,
    'title': '环球梦工厂系列',
    'tag': '成长/家庭故事/真善美',
    'lists': ['小王子', '纳尼亚传奇', '加勒比海盗：风林火山', '傲慢与偏见'],
    'images': 'images/bookPic_3.png',
    'manager': 'Bill',
    'avatar': 0xCDB38B,
    'buy': false,
    'pay': true,
    'date': '课程时间：3月28日-6月16日',
    'cost': 199
  },
];

List<Books> booksList = ListData.map((item) => Books.fromJSON(item)).toList();