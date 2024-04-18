import 'dart:convert';

import 'package:bloc_api_call_curd_app/presentation/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class RestApiSerivces {
  Future<bool> delelteById(String id) async {
    http.Response response =
        await http.delete(Uri.parse('https://api.nstack.in/v1/todos/$id'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> addUserService(
      String title, String description, bool iscompleted) async {
    print("hlo");
    try {
      final Map<String, dynamic> map = {
        "title": title,
        "description": description,
        "is_completed": iscompleted,
      };
      http.Response response = await http.post(
        Uri.parse('https://api.nstack.in/v1/todos'),
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        return true;
      } else {
        print(response.statusCode);
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  UserModel _userModel = UserModel();
  Future<UserModel> readUserService() async {
    try {
      http.Response response = await http.get(
        Uri.parse('https://api.nstack.in/v1/todos?page=1&limit=10'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        _userModel = await compute(
          _pareJson,
          response.body,
        );
      }
    } catch (e) {
      throw Exception(e);
    }
    return _userModel;
  }

  Future<bool> updateUserService(
      String id, String title, String description, bool iscompleted) async {
    try {
      final Map<String, dynamic> map = {
        "title": title,
        "description": description,
        "is_completed": iscompleted,
      };
      http.Response response = await http.put(
        Uri.parse(
          'https://api.nstack.in/v1/todos/$id',
        ),
        body: jsonEncode(map),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

UserModel _pareJson(String json) => UserModel.fromJson(jsonDecode(json));
