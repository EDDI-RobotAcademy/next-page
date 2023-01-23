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

class EpisodeUploadRequest {
  int informationId;
  int episodeNumber;
  String episodeTitle;
  String text;
  bool needToBuy;

  EpisodeUploadRequest(this.informationId, this.episodeNumber,
      this.episodeTitle, this.text, this.needToBuy);
}

class EpisodeModifyRequest{
  int episodeNumber;
  String episodeTitle;
  String text;
  bool needToBuy;
  int episodeId;

  EpisodeModifyRequest(
      this.episodeNumber,
      this.episodeTitle,
      this.text,
      this.needToBuy,
      this.episodeId
      );
}