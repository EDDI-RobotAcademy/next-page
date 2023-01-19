class CommentResponse {
  final int commentNo;
  final String comment;
  final String nickName;
  final String regDate;

  CommentResponse({
    required this.commentNo,
    required this.comment,
    required this.nickName,
    required this.regDate
  });

  factory CommentResponse.fromJson(Map<String, dynamic> json) {
    return CommentResponse(
        commentNo: json["commentNo"],
        comment: json["comment"],
        nickName: json["nickName"],
        regDate: json["regDate"]);
  }
}