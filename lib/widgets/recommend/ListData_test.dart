class Books {
  final String groupId;
  final bool recommend;
  final String title;
  final String tag;
  final List lists;
  final String images;
  final String manager;
  final String date;
  final String avatar;
  final int cost;
  bool buy;
  bool pay;
  Books({this.groupId, this.recommend, this.title, this.tag, this.lists, this.images, this.manager, this.avatar, this.buy, this.pay, this.date, this.cost});

  factory Books.fromJSON(Map<String, dynamic> json) {
    return Books(
        groupId: json['group_id'],
        recommend: json['recommend'],
        title: json['name'],
        tag: json['tag'],
        lists: json['book_list'],
        images: json['cover'],
        manager: json['editor'],
        avatar: json['avatar'],
        buy: json['buy'],
        pay: json['pay'],
        date: json['date'],
        cost: json['cost']
    );
  }
}