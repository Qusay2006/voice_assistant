import 'package:injectable/injectable.dart';

import '../data/ai_service_data.dart';

abstract interface class OpenAiRepo {
  Future<String> processPrompt(String prompt);
  Future<String> getResponse(String prompt);
  Future<String> generateImage(String prompt);
}

@LazySingleton(as: OpenAiRepo)
class OpenAiRepoImpl implements OpenAiRepo {
  final AiServiceData _openAiData;

  OpenAiRepoImpl({required AiServiceData openAiData}) : _openAiData = openAiData;

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
  Future<String> getResponse(String prompt) async {
    try {
      if (prompt.trim().isEmpty)
        return '';
      return await _openAiData.geminiChat(prompt);
    } catch (e) {
      throw Exception('ChatGPT Error: $e');
    }
  }

  @override
  Future<String> generateImage(String prompt) async {
    try {
      if (prompt.trim().isEmpty)
        return '';
      return await _openAiData.generateImage(prompt);
    } catch (e) {
      throw Exception('DALL-E Error: $e');
    }
  }
}