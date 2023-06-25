import 'package:http/http.dart' as http;
import 'dart:convert';

class PostUser {
  int? code;
  bool? status;
  String? message;
  Map<String, dynamic>? user;

  PostUser({this.code, this.status, this.message, this.user});

  factory PostUser.createData(Map<String, dynamic> object) {
    return PostUser(
        code: object['code'],
        status: object['status'],
        message: object['message'],
        user: object['user']);
  }

  static Future<PostUser> connectToAPI(String email, String password) async {
    String apiURL = "https://demo.treblle.com/api/v1/auth/login";

    var apiResult = await http.post(Uri.parse(apiURL),
        headers: {'': 'lsGPLl4k6Vc4J0VhnFaMBqetNtn1ofsB'},
        body: {'email': email, 'password': password});
    var jsonObject = json.decode(apiResult.body);

    return PostUser.createData(jsonObject);
  }
}
