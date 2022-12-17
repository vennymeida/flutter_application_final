import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/category_model.dart';

const String baseUrl = "http://10.0.2.2:8000/api/";

errorSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.red,
    content: Text(text),
    duration: const Duration(seconds: 1),
  ));
}

_save(String key, String data) async {
  final prefs = await SharedPreferences.getInstance();
  //const key = 'token';
  //final value = token;
  prefs.setString(key, data);
}

read() async {
  final prefs = await SharedPreferences.getInstance();
  const key = 'token';
  final value = prefs.get(key) ?? 0;
  print('read : $value');
}

class CRUD {
  Future<Response> addCategory(String name) async {
    final url = Uri.parse(baseUrl + 'category');
    SharedPreferences pref = await SharedPreferences.getInstance();
    const key = 'token';
    final value = pref.get(key);
    final token = value;
    final body = {
      'name': name,
    };
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + '$token',
    };

    final response = await post(url, body: body, headers: headers);
    return response;
  }

  Future<Response> editCategori(Category category, String name) async {
    final url = Uri.parse(baseUrl + 'category/${category.id}');
    SharedPreferences pref = await SharedPreferences.getInstance();
    const key = 'token';
    final value = pref.get(key);
    final token = value;
    final body = {
      'name': name,
    };
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + '$token',
    };

    final response = await put(url, body: body, headers: headers);
    return response;
  }

  Future<Response> deleteCategori(Category category) async {
    final url = Uri.parse(baseUrl + 'category/${category.id}');
    SharedPreferences pref = await SharedPreferences.getInstance();
    const key = 'token';
    final value = pref.get(key);
    final token = value;
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + '$token',
    };

    final response = await delete(url, headers: headers);
    return response;
  }
}
