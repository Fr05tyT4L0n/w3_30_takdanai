// package services
import 'dart:convert';
import 'package:http/http.dart' as http;

// models
import 'package:w3_30_takdanai/users_model.dart';

class ApiService {
  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse("https://696457cde8ce952ce1f16e71.mockapi.io/users"));

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((res) => Users.fromJson(res)).toList();
    } else {
      throw Exception('Kirov Reporting! ${response.statusCode}');
    }
  }
}