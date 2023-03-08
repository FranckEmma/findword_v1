import 'package:findword_v1/model/word_service.dart';

class WordRepository {
  WordRepository._internal();
  static final WordRepository instance = WordRepository._internal();
  final WordService _service = WordService.instance;

  Future<bool> getWordDescription(String word) async {
      final response = await _service.wordRequest(word);
      return response;

  }

}