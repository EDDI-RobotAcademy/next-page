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

class NoticeRequest{
  final int novelInfoId;
  final int page;
  final int size;

  NoticeRequest({
    required this.novelInfoId,
    required this.page,
    required this.size
  });
}