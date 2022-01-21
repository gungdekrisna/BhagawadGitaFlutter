import 'dart:convert';

import 'package:bhagawad_gita/sloka.dart';
import 'package:http/http.dart' as http;

class PostResult {
  List<Sloka> sloka;

  PostResult({ required this.sloka});

  static Future connectToAPI(String word) async
  {
    String apiURL = "http://192.168.43.165:5000/search";

    var apiResult = await http.post(apiURL, body: {
      "nm": word
    });

    Iterable it = jsonDecode(apiResult.body);
    List<Sloka> slokas = it.map((e) => Sloka.fromJson(e)).toList();

    return slokas;
  }
}