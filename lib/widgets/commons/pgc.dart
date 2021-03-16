class Pgc {
  final String sTag;
  final String title;
  final String subTitle;
  final int like;
  final String cover;
  final String pId;
  Pgc({ this.sTag, this.title, this.subTitle, this.like, this.cover, this.pId });

  factory Pgc.fromJSON(Map<String, dynamic> json) {
    return Pgc(
        sTag: json['tag'],
        title: json['title'],
        subTitle: json['subTitle'],
        like: json['like'],
        cover: json['cover'],
        pId: json['p_id']
    );
  }
}