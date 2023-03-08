import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class WordService {
  WordService._internal();

  static final WordService instance = WordService._internal();

  final String baseUrl = 'https://api.dictionaryapi.dev/api/v2/entries/en/';
  final Dio _dio = Dio();

  Future<bool> wordRequest(String word) async {
    try {
      final response = await _dio.get<List>(baseUrl + word);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = response.data?[0];
        if (jsonResponse.containsKey("word") &&
            jsonResponse["word"].toLowerCase() == word.toLowerCase()) {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
