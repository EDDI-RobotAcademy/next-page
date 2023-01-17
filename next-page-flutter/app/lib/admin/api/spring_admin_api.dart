import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../../http_uri.dart';
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
}
