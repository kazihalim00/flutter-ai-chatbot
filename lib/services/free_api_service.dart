import 'dart:convert';
import 'package:http/http.dart' as http;

class FreeApiService {
  Future<String> getResponse() async {
    try {

      final res = await http.get(Uri.parse("https://dummyjson.com/quotes/random"));

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return "${data['quote']}\n— ${data['author']}";
      } else {
        throw Exception("Free API error: ${res.statusCode}");
      }
    } catch (e) {
      throw Exception("Connection Error: Please check your internet.");
    }
  }
}