import 'package:dio/dio.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

@module
abstract class RegisterModule {
  Dio get dio => Dio();
@lazySingleton
SpeechToText get speechToText => SpeechToText();

@lazySingleton
  FlutterTts get flutterTts => FlutterTts();
}