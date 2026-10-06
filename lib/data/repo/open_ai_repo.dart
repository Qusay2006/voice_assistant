import 'package:injectable/injectable.dart';

import '../data/open_ai_data.dart';

abstract interface class OpenAiRepo {
  Future<String> processPrompt(String prompt);
  Future<String> getChatResponse(String prompt);
  Future<String> generateImage(String prompt);
}

@LazySingleton(as: OpenAiRepo)
class OpenAiRepoImpl implements OpenAiRepo {
  final OpenAiData _openAiData;

  OpenAiRepoImpl({required OpenAiData openAiData}) : _openAiData = openAiData;

  @override
  Future<String> processPrompt(String prompt) async {
    try {
      if (prompt.trim().isEmpty)
        return '';
      return await _openAiData.isArtFromApi(prompt);
    } catch (e) {
      throw Exception('Process Error: $e');
    }
  }

  @override
  Future<String> getChatResponse(String prompt) async {
    try {
      if (prompt.trim().isEmpty)
        return '';
      return await _openAiData.chatGpt(prompt);
    } catch (e) {
      throw Exception('ChatGPT Error: $e');
    }
  }

  @override
  Future<String> generateImage(String prompt) async {
    try {
      if (prompt.trim().isEmpty)
        return '';
      return await _openAiData.DallE(prompt);
    } catch (e) {
      throw Exception('DALL-E Error: $e');
    }
  }
}