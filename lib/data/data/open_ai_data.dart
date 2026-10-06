import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:voice_assistant/core/secret/api_key.dart';

abstract interface class OpenAiData {
Future<String> isArtFromApi(String prompt);
Future<String> chatGpt(String prompt);
Future<String> DallE(String prompt);
}

@LazySingleton(as: OpenAiData)
class OpenAiDataImpl implements OpenAiData {
  final Dio _dio;

  OpenAiDataImpl({required this._dio});
  //لحتى يتذكر ال شات حكينا
 final List<Map<String,String>> messages =[];

  @override
  Future<String> isArtFromApi(String prompt) async {
    try {
      final result = await _dio.post(
          'https://api.openai.com/v1/chat/completions',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $apiKey',
              }),
          data: {
            'model': 'gpt-3.5-turbo',
            'messages': [
              {
                'role': 'user',
                'content': 'Does this message want to generate ai picture or anything similar? $prompt . Simply answer with yes or no.'
              },
            ]
          });

      //عندما ترسل طلب POST إلى OpenAI، يرجع لك السيرفر استجابة بهذا الشكل تماماً:
      String content = result.data["choices"][0]["message"]["content"]
          .toString()
          .trim()
          .toLowerCase();
      // لنرجع اذا اي مشان صورة DallE اذا لا مشان chatGPT
      return content.contains('yes') ? await DallE(prompt) : await chatGpt(prompt);
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }





  @override
  Future<String> DallE(String prompt) async {

    try {
      final result = await _dio.post(
          'https://api.openai.com/v1/images/generations',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $apiKey',
              }),
          data: {
            'model': 'dall-e-3',
            'prompt': prompt,
            'n': 1,
            'size': '1024x1024',
          });
      return result.data['data'][0]['url'].toString();
    } on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }






  @override
  Future<String> chatGpt(String prompt) async {
      messages.add({
        'role': 'user',
        'content': prompt,
      });
      try {
      final result = await _dio.post(
          'https://api.openai.com/v1/chat/completions',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $apiKey',
              }),
          data: {
            'model': 'gpt-3.5-turbo',
            'messages': messages
          });
      final data = result.data['choices'][0]['message']['content'].toString().trim();
      messages.add({
        'role': 'assistant',
        'content': data,
      });
      return data;

    }
    on DioException catch (e) {
      throw Exception(e.toString());
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}