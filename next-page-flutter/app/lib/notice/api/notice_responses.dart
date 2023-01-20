class NoticeResponse{
  final int noticeNo;
  final String title;
  final String content;
  final String createdDate;
  final String noticeCategory;
  final int novelInfoId;

  NoticeResponse({
    required this.noticeNo,
    required this.title,
    required this.content,
    required this.createdDate,
    required this.noticeCategory,
    required this.novelInfoId
});

  factory NoticeResponse.fromJson(Map<String, dynamic> json) {
    return NoticeResponse(
    noticeNo: json['noticeNo'],
    title: json['title'],
    content: json['content'],
    createdDate: json['createdDate'],
    noticeCategory: json['noticeCategory'],
    novelInfoId: json['novelInfoId']);
  }
}