import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://localhost:8080/api/auth";

  Future<String> testConnection() async {
    final response = await http.get(Uri.parse("$baseUrl/test"));

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception(
          "Failed to connect to backend. Status: ${response.statusCode}");
    }
  }
}
