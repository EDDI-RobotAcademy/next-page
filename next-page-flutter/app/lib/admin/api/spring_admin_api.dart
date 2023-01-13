import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import '../../http_uri.dart';
import 'upload_requests.dart';

class SpringAdminApi {
  Future<bool> uploadNovelInformation(
      XFile image, NovelUploadRequest request) async {
    final MultipartFile _file = MultipartFile.fromFileSync(
        image.path, contentType: MediaType("image", "jpg"));

    // 파일 경로를 통해 formData 생성
    var dio = Dio();
    var _formData = FormData.fromMap({
      'file': _file,
      'info': MultipartFile.fromString(jsonEncode({
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
}
