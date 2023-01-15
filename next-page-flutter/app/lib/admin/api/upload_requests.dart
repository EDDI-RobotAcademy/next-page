class NovelUploadRequest {
  String title;
  String category;
  bool openToPublic;
  int purchasePoint;
  String author;
  String publisher;
  String introduction;
  int memberId;

  NovelUploadRequest(this.title, this.category, this.openToPublic, this.author,
      this.purchasePoint, this.publisher, this.introduction, this.memberId);
}

class NovelModifyRequest {
  String title;
  String category;
  bool openToPublic;
  int purchasePoint;
  String author;
  String publisher;
  String introduction;

  NovelModifyRequest(this.title, this.category, this.openToPublic, this.author,
      this.purchasePoint, this.publisher, this.introduction);
}