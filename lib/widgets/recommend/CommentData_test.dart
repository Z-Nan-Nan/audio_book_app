class Comment {
  final String avatar;
  final String name;
  final double star;
  final String text;
  int like;
  bool isLike;
  bool top;

  Comment({this.avatar, this.name, this.star, this.like, this.text, this.isLike, this.top});

  Comment.fromJSON(Map<String, dynamic> data):
        avatar = data['avatar'],
        name = data['name'],
        star = data['rate'],
        like = data['like'],
        text = data['content'],
        isLike = data['is_like'],
        top = data['top'];
}

// List<dynamic> commentData = [
//   {
//     'avatar': 'blue',
//     'name': '百香果爱喝酒',
//     'star': 4.5,
//     'like': 23,
//     'text': '又是一年圣诞，南方的冬日暖阳白花花，虽过不了白色圣诞节，过白日圣诞也是好的。 又是一年圣诞，南方的冬日暖阳白花花。',
//     'isLike': true,
//     'top': true
//   },
//   {
//     'avatar': 'blue',
//     'name': '肖赞赞',
//     'star': 5.0,
//     'like': 23,
//     'text': '又是一年圣诞，南方的冬日暖阳白花花，虽过不了白色圣诞节，过白日圣诞也是好的。 又是一年圣诞，南方的冬日暖阳白花花。',
//     'isLike': false,
//     'top': false
//   },
//   {
//     'avatar': 'blue',
//     'name': '王甜甜',
//     'star': 4.5,
//     'like': 23,
//     'text': '又是一年圣诞，南方的冬日暖阳白花花，虽过不了白色圣诞节，过白日圣诞也是好的。 又是一年圣诞，南方的冬日暖阳白花花。',
//     'isLike': false,
//     'top': false
//   }
// ];