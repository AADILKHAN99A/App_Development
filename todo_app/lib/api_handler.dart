import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiConstant {
  static const String url = "https://api.nstack.in/v1/todos";
  static const Map<String, String> header = {
    'Content-Type': 'application/json'
  };
}

class ApiHelper {
  static Future fetchPost() async {
    final uri = Uri.parse(ApiConstant.url);
    final response = await http.get(uri, headers: ApiConstant.header);
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final result = json['items'] as List;

      return result;
    } else {
      return null;
    }
  }

  static Future deletePost({required String id, required List items}) async {
    final url = '${ApiConstant.url}/$id';
    final uri = Uri.parse(url);

    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updatePost(
      {required String id,
      required String title,
      required String description}) async {
    final url = '${ApiConstant.url}/$id';
    final uri = Uri.parse(url);
    final body = {
      "title": title.toString(),
      "description": description.toString(),
      "is_completed": false
    };
    print(body);
    final encodedBody = jsonEncode(body);
    final response =
        await http.put(uri, body: encodedBody, headers: ApiConstant.header);
    if (response.statusCode == 200) {
      return true;
    } else {
      print(response.statusCode);
      return false;
    }
  }
}

class ShowMessage {
  static void showSuccessMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.blueAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showErrorMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.redAccent,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    throw Exception("Failed to Post");
  }
}
