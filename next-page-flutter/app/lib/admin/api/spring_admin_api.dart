import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../../comment/api/comment_requests.dart';
import '../../http_uri.dart';
import '../../mypage/api/responses.dart';
import '../../utility/providers/novel_list_provider.dart';
import 'upload_requests.dart';
import 'package:http/http.dart' as http;

class SpringAdminApi {
  Future<bool> uploadNovelInformation(
      XFile image, NovelUploadRequest request) async {
    final MultipartFile _file = MultipartFile.fromFileSync(image.path,
        contentType: MediaType("image", "jpg"));

    // 파일 경로를 통해 formData 생성
    var dio = Dio();
    var _formData = FormData.fromMap({
      'file': _file,
      'info': MultipartFile.fromString(
          jsonEncode({
            'title': request.title,
            'category': request.category,
            'openToPublic': request.openToPublic,
            'purchasePoint': request.purchasePoint,
            'author': request.author,
            'publisher': request.publisher,
            'introduction': request.introduction,
            'member_id': request.memberId
          }),
          contentType: MediaType.parse('application/json'))
    });

    var response = await dio.post(
      'http://$httpUri/novel/information-register',
      data: _formData,
    );
    if (response.statusCode == 200) {
      NovelListProvider().getAllNovelList();
      return true;
    } else {
      throw false;
    }
  }

  Future<bool> modifyNovelInformationWithImage(
      XFile image, int novelId, NovelModifyRequest request) async {
    final MultipartFile _file = MultipartFile.fromFileSync(image.path,
        contentType: MediaType("image", "jpg"));

    // 파일 경로를 통해 formData 생성
    var dio = Dio();
    var _formData = FormData.fromMap({
      'file': _file,
      'info': MultipartFile.fromString(
          jsonEncode({
            'title': request.title,
            'category': request.category,
            'openToPublic': request.openToPublic,
            'purchasePoint': request.purchasePoint,
            'author': request.author,
            'publisher': request.publisher,
            'introduction': request.introduction,
          }),
          contentType: MediaType.parse('application/json'))
    });

    var response = await dio.post(
      'http://$httpUri/novel/information-modify-with-file/$novelId',
      data: _formData,
    );
    if (response.statusCode == 200) {
      NovelListProvider().getAllNovelList();
      return true;
    } else {
      throw false;
    }
  }

  Future<bool> modifyNovelInformationWithoutImage(
      int novelId, NovelModifyRequest request) async {
    var data = {
      'title': request.title,
      'category': request.category,
      'openToPublic': request.openToPublic,
      'purchasePoint': request.purchasePoint,
      'author': request.author,
      'publisher': request.publisher,
      'introduction': request.introduction,
    };
    var body = json.encode(data);
    print("modify novel: " + body);

    var response = await http.post(
      Uri.http(httpUri, '/novel/information-modify-text/$novelId'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      NovelListProvider().getAllNovelList();
      print("소설 정보 수정 통신 확인");
      return true;
    } else {
      print("소설 정보 수정 통신 실패");
      return false;
    }
  }

  Future<bool> uploadEpisode(EpisodeUploadRequest request) async {
    var data = {
      'information_id': request.informationId,
      'episodeNumber': request.episodeNumber,
      'episodeTitle': request.episodeTitle,
      'text': request.text,
      'needToBuy': request.needToBuy,
    };
    var body = json.encode(data);
    print("upload episode: $body");

    var response = await http.post(
      Uri.http(httpUri, '/novel/episode-register/'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      print("에피소드 업로드 통신 확인");
      return true;
    } else {
      print("에피소드 업로드 통신 실패");
      return false;
    }
  }

  Future<List<QnA>?> getAllQnaList() async {

    var response = await http.get(
      Uri.http(httpUri, '/qna/list'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      print("getAllQnaList 통신 확인");

      var jsonData = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      print(jsonData.toString());

      List<QnA> qnaList = jsonData.map((dataJson) => QnA.fromJson(dataJson)).toList();

      return qnaList;

    } else {
      throw Exception("getMyQnaList 통신 실패");
    }
  }

  Future<bool> writeQnaComment(int qnaNo, CommentWriteRequest request) async {
    var data = { 'commentWriterId' : request.memberId, 'comment' : request.comment };
    var body = json.encode(data);
    print("write comment: " + body);

    var response = await http.post(
      Uri.http( httpUri, '/comment/write-for-qna/$qnaNo'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if(response.statusCode == 200) {
      print("댓글 작성 통신 확인");
      return true;
    } else {
      print("댓글 작성 통신 실패");
      return false;
    }
  }

  Future<bool> deleteQnaComment(int qnaNo) async {
    var response = await http.delete(
      Uri.http( httpUri, '/comment/delete-qna-comment/$qnaNo'),
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200) {
      print("qna 댓글 삭제 통신 확인");
      return true;
    } else {
      print("qna 댓글 삭제 통신 실패");
      return false;
    }
  }

  Future<bool> deleteEpisode(int episodeId) async {
    var response = await http.delete(
      Uri.http( httpUri, '/novel/delete-episode/$episodeId'),
      headers: {"Content-Type": "application/json"},
    );

    if(response.statusCode == 200) {
      print("에피소드 삭제 통신 확인");
      return true;
    } else {
      print("에피소드 삭제 통신 실패");
      return false;
    }
  }

  Future<bool> modifyEpisode(EpisodeModifyRequest request) async {
    var data = {
      'episodeNumber' : request.episodeNumber,
      'episodeId' : request.episodeId,
      'episodeTitle' : request.episodeTitle,
      'text' : request.text,
      'needToBuy' : request.needToBuy
    };
    var body = json.encode(data);
    print("modify comment: " + body);

    var response = await http.put(
      Uri.http( httpUri, '/novel/modify-episode/${request.episodeId}'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if(response.statusCode == 200) {
      print("에피소드 수정 통신 확인");
      return true;
    } else {
      print("에피소드 수정 통신 실패");
      return false;
    }
  }

}
