import 'dart:collection';

class NovelListResponse {
  int id;
  String title;
  String introduction;
  String publisher;
  String author;
  int purchasePoint;
  bool openToPublic;
  String createdDate;
  LinkedHashMap<String, dynamic> coverImage;

  NovelListResponse(
      {required this.id,
      required this.title,
      required this.introduction,
      required this.publisher,
      required this.author,
      required this.purchasePoint,
      required this.openToPublic,
      required this.createdDate,
      required this.coverImage});

  factory NovelListResponse.fromJson(Map<String, dynamic> json) {
    return NovelListResponse(
        id: json["id"],
        title: json["title"],
        introduction: json["introduction"],
        publisher: json["publisher"],
        author: json["author"],
        purchasePoint: json["purchasePoint"],
        openToPublic: json["openToPublic"],
        createdDate: json["createdDate"],
        coverImage: json["coverImage"]);
  }
}

class NovelResponse {
  int id;
  String title;
  String introduction;
  String publisher;
  String author;
  int purchasePoint;
  bool openToPublic;
  String createdDate;
  String category;
  String thumbnail;
  int viewCount;
  double starRating;
  int commentCount;

  NovelResponse(
      {required this.id,
      required this.title,
      required this.introduction,
      required this.publisher,
      required this.author,
      required this.purchasePoint,
      required this.openToPublic,
      required this.createdDate,
      required this.category,
      required this.thumbnail,
      required this.viewCount,
      required this.starRating,
      required this.commentCount});

  factory NovelResponse.fromJson(Map<String, dynamic> json) {
    return NovelResponse(
        id: json["id"],
        title: json["title"],
        introduction: json["introduction"],
        publisher: json["publisher"],
        author: json["author"],
        purchasePoint: json["purchasePoint"],
        openToPublic: json["openToPublic"],
        createdDate: json["createdDate"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        viewCount: json["viewCount"],
        starRating: json["starRating"],
        commentCount: json["commentCount"]);
  }
}

class EpisodeResponse {
  int id;
  int episodeNumber;
  String episodeTitle;
  String text;
  bool needToBuy;
  String uploadedDate;

  EpisodeResponse(
      {required this.id,
      required this.episodeNumber,
      required this.episodeTitle,
      required this.text,
      required this.needToBuy,
      required this.uploadedDate});

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
        id: json["id"],
        episodeNumber: json["episodeNumber"],
        episodeTitle: json["episodeTitle"],
        text: json["text"],
        needToBuy: json["needToBuy"],
        uploadedDate: json["uploadedDate"]);
  }
}

class PurchasedEpisodeListResponse {
  int id;
  String paymentDate;
  int episodeId;

  PurchasedEpisodeListResponse(
      {required this.id, required this.paymentDate, required this.episodeId});

  factory PurchasedEpisodeListResponse.fromJson(Map<String, dynamic> json) {
    return PurchasedEpisodeListResponse(
        id: json["id"],
        paymentDate: json["paymentDate"],
        episodeId: json["episodeId"]);
  }
}
