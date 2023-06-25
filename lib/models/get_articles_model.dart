import 'package:http/http.dart' as http;
import 'dart:convert';

class GetArticles {
  int? code;
  bool? status;
  String? message;
  List<dynamic>? articles;

  GetArticles({this.code, this.status, this.message, this.articles});

  factory GetArticles.createData(Map<String, dynamic> object) {
    return GetArticles(
        code: object['code'],
        status: object['status'],
        message: object['message'],
        articles: object['articles']);
  }

  static Future<GetArticles> connectToApi() async {
    String apiURL = "https://demo.treblle.com/api/v1/articles";

    var apiResult = await http.get(
      Uri.parse(apiURL),
      headers: {'': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB'},
    );
    var jsonObject = json.decode(apiResult.body);

    return GetArticles.createData(jsonObject);
  }
}
