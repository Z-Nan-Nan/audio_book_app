class CommentVector {
  final String content;
  final Object authorInfo;
  final String status;
  final String kind;
  int like;
  final bool top;
  bool isLike;
  CommentVector({ this.content, this.authorInfo, this.status, this.like, this.kind, this.top, this.isLike });

  factory CommentVector.fromJSON(Map<String, dynamic> json) {
    return CommentVector(
        content: json['content'],
        authorInfo: json['author_info'],
        status: json['status'],
        like: json['like'],
        kind: json['kind'],
        top: json['top'],
        isLike: json['comment_is_like']
    );
  }
}