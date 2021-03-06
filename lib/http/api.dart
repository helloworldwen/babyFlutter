import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';

class Service {
  Dio http = new Dio();

  static final Service _instance = new Service._();

  static Service getInstance() {
    return _instance;
  }

  Service._() {
    http.options.baseUrl = 'http://39.108.227.137:3000';
  }

  getLoves() async {}

  addLove(String content, String userId) async {
    Map body = {
      "love": {"content": content, "userId": userId}
    };

    // 请求
    var response = await http.post(
      "/api/v1/love",
      data: body,
    );

    return response.data.toString();
  }

  updateLove(int id, String content, String userId) async {
    var response = await http.put(
      "/api/v1/love",
      data: {
        "love": {"content": content, "userId": userId, "id": id}
      },
    );

    return response.data.toString();
  }

  deleteLove(int id) async {
    var response = await http.delete(
      "/api/v1/love",
      data: {"loveId": id},
    );
    return response.data.toString();
  }

  addLoveWithImage(
      List<File> images, String content, String userId, bool remind) async {
    List<UploadFileInfo> files = [];

    images.forEach((f) {
      files.add(new UploadFileInfo(f, basename(f.path)));
    });

    Map<String, dynamic> param = {
      "content": content,
      "userId": userId,
      "remind": remind
    };

    if (images.length != 0) {
      param['images'] = files;
    }

    FormData formData = new FormData.from(param);
    var response = await http.post("/api/v1/love/image", data: formData);
    return response.data.toString();
  }
}
