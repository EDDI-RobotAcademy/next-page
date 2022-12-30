import 'dart:collection';

class NovelListRequest {
  int id;
  String title;
  String introduction;
  String publisher;
  String author;
  int purchasePoint;
  bool openToPublic;
  String createdDate;
  LinkedHashMap<String, dynamic> coverImage;

  NovelListRequest(
      {required this.id,
        required this.title,
        required this.introduction,
        required this.publisher,
        required this.author,
        required this.purchasePoint,
        required this.openToPublic,
        required this.createdDate,
        required this.coverImage});

  factory NovelListRequest.fromJson(Map<String, dynamic> json) {
    return NovelListRequest(
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

class NovelRequest {
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

  NovelRequest(
      {required this.id,
        required this.title,
        required this.introduction,
        required this.publisher,
        required this.author,
        required this.purchasePoint,
        required this.openToPublic,
        required this.createdDate,
        required this.category,
        required this.thumbnail});

  factory NovelRequest.fromJson(Map<String, dynamic> json) {
    return NovelRequest(
        id: json["id"],
        title: json["title"],
        introduction: json["introduction"],
        publisher: json["publisher"],
        author: json["author"],
        purchasePoint: json["purchasePoint"],
        openToPublic: json["openToPublic"],
        createdDate: json["createdDate"],
        category: json["category"],
        thumbnail: json["thumbnail"]);
  }
}