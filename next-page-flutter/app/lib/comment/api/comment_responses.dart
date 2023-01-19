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

class CommentAndEpisodeResponse{
  final int commentNo;
  final String comment;
  final String nickName;
  final String regDate;
  final String novelTitle;
  final int episodeNumber;
  final String episodeTitle;

  CommentAndEpisodeResponse({
    required this.commentNo,
    required this.comment,
    required this.nickName,
    required this.regDate,
    required this.novelTitle,
    required this.episodeTitle,
    required this.episodeNumber
});

  factory CommentAndEpisodeResponse.fromJson(Map<String, dynamic> json) {
    return CommentAndEpisodeResponse(
        commentNo: json["commentNo"],
        comment: json["comment"],
        nickName: json["nickName"],
        regDate: json["regDate"],
        novelTitle: json["novelTitle"],
        episodeTitle: json["episodeTitle"],
        episodeNumber: json["episodeNumber"]);
  }
}