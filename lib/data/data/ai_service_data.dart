import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:voice_assistant/core/secret/api_key.dart';

abstract interface class AiServiceData {
Future<String> isArtFromApi(String prompt);
Future<String> geminiChat(String prompt);
Future<String> generateImage(String prompt);
}

@LazySingleton(as: AiServiceData)
class AiServiceDataImpl implements AiServiceData {
  final Dio _dio;

  AiServiceDataImpl({required this._dio});
  //لحتى يتذكر ال شات حكينا
 final List<Map<String,String>> messages =[];
  static const _model = 'gemini-3.5-flash-lite';
  static const _url =
      'https://generativelanguage.googleapis.com/v1beta/models/$_model:generateContent';


  @override
  Future<String> isArtFromApi(String prompt) async {
    const intentInstruction = {
      'text': 'Read the user prompt and determine if they want to create an image, like generating, drawing, or showing a picture, or if they want to have a text conversation. Return "image" if they want to generate an image and "text" if they want a text conversation. Return ONLY "image" or "text".',
    };

    try {
      final result = await _dio.post(_url,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'x-goog-api-key': apiKey,
              }),
          data: {
            'systemInstruction': {
              'parts': [intentInstruction]
            },
            'contents': [
              {
                'role': 'user',
                'parts': [
                  {'text': prompt}
                ],
              }
            ],
          });

      String detectedIntent = result.data['candidates'][0]['content']['parts'][0]['text']
          .toString()
          .trim()
          .toLowerCase();

      if (detectedIntent.contains('image')) {
        return generateImage(prompt);
      } else {
        return geminiChat(prompt);
      }
    } catch (e) {
      return geminiChat(prompt);
    }
  }


  @override
  Future<String> geminiChat(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt});

    try {
      final result = await _dio.post(_url,
          options: Options(
              headers: {
                'Content-Type': 'application/json',
                'x-goog-api-key': apiKey,
              }),
          data: {
            'systemInstruction': {
              'parts': [
                {
                  'text': 'You are Allen, a friendly voice assistant. '
                      'Answer briefly in plain text, with no markdown, '
                      'lists, or symbols, because your answer is read aloud.'
                }
              ]
            },
            'contents': messages
                .map((m) => {
              'role': m['role'] == 'assistant' ? 'model' : 'user',
              'parts': [
                {'text': m['content']}
              ],
            })
                .toList(),
          });

      String text = result.data['candidates'][0]['content']['parts'][0]['text']
          .toString()
          .trim();
      messages.add({'role': 'assistant', 'content': text});
      return text;
    } on DioException catch (e) {
      messages.removeLast();
      print(e.response?.data);
      throw Exception(e.response?.data?.toString() ?? e.message);
    } catch (e) {
      messages.removeLast();
      throw Exception(e.toString());
    }
  }




  @override
  Future<String> generateImage(String prompt) async {
    try {
      final encoded = Uri.encodeComponent(prompt);

      return 'https://image.pollinations.ai/prompt/$encoded?model=turbo';
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}