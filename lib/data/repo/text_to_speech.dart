import 'dart:io';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';

abstract interface class TextToSpeechRepo {
Future<void> init();
Future<void> stop();
Future<String> speak(String content);
}

@LazySingleton(as :TextToSpeechRepo)
class TextToSpeechRepoImpl implements TextToSpeechRepo{
final FlutterTts _textToSpeech;

  TextToSpeechRepoImpl({required FlutterTts textToSpeech})
  : _textToSpeech=textToSpeech;

  @override
  Future<void> init()async {
    if(Platform.isIOS){
      await _textToSpeech.setSharedInstance(true);
    }
  }

@override
  Future<void>stop()async{
    await _textToSpeech.stop();
  }

  @override
  Future<String> speak(String content) async{
   try{
     if(content.isEmpty)
       return '' ;
     //لانو dynamic بيرجع 1 او 0
     final result = await _textToSpeech.speak(content);
     if(result == 1){
       return content;
     }
     else{
       throw Exception('Error');
     }
   }
   catch (e){
     throw Exception(e.toString());
   }
  }

}