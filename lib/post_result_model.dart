import 'dart:convert';

import 'package:bhagawad_gita/sloka.dart';
import 'package:http/http.dart' as http;

class PostResult {
  List<Sloka> sloka;

  PostResult({ required this.sloka});

  factory PostResult.createPostResult(List<Sloka> object) {
    return PostResult(
      sloka: object
    );
  }

  static Future<PostResult> connectToAPI(String word) async
  {
    String apiURL = "http://192.168.43.165:5000/search";

    var apiResult = await http.post(apiURL, body: {
      "nm": word
    });

    var jsonObject = json.decode(apiResult.body);

    return PostResult.createPostResult(jsonObject);
  }
}