import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIService {
  static String get apiKey => dotenv.env['OPENAI_API_KEY'] ?? "";

  Future<String> sendMessage(String message) async {
    if (apiKey.isEmpty) throw Exception("API Key missing in .env file.");

    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {"role": "user", "content": message}
          ]
        }),
      );

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        return data["choices"][0]["message"]["content"];
      } else {
        final errorData = jsonDecode(res.body);
        throw Exception(errorData['error']['message'] ?? "Quota exceeded");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}