import 'dart:convert';
import 'package:hr/model/work.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<Work>> getWorks() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2/hr_api/getWorks.php'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Work.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load works');
    }
  }
}
