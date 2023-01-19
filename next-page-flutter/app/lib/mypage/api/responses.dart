class QnA {
  int qnaNo;
  String title;
  String category;
  String content;
  String regDate;
  bool hasComment;
  String comment;
  String commentRegDate;

  QnA({
    required this.qnaNo,
    required this.category,
    required this.title,
    required this.content,
    required this.regDate,
    required this.hasComment,
    required this.comment,
    required this.commentRegDate
    });

  factory QnA.fromJson(Map<String, dynamic> json) {
    return QnA(
      qnaNo: json['qnaNo'],
      category: json['category'],
      title: json['title'],
      content: json['content'],
      regDate: json['regDate'],
      hasComment: json['hasComment'],
      comment: json['comment'],
      commentRegDate: json['commentRegDate']
    );
  }


}