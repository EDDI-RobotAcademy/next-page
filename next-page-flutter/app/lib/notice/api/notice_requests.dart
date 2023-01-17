class WriteNoticeRequest{
  final String title;
  final String content;
  final String noticeCategory;
  final int novelInfoId;

  WriteNoticeRequest({
    required this.title,
    required this.content,
    required this.noticeCategory,
    required this.novelInfoId
  });
}