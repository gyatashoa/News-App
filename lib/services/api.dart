import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:news_app/models/news_model.dart';

class ApiCall {
  final String _api = "https://newsapi.org/v2/";
  String key = "92629c31ac0f4bcb8da30c06c55f8787";

  Future<List<News>> makeCall() async {
    String combined = "${_api}top-headlines?country=us&apiKey=${key}";
    http.Response res = await http.get(combined);
    var decodeRes = convert.jsonDecode(res.body);
    List news = decodeRes["articles"];
    return news.map((e) => News(e)).toList();
  }
}
