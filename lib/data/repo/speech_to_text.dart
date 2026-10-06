import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract interface class SpeechToTextRepo {
  Future<bool> init();
  Future<void> startListening(void Function(String words) onResult);
  Future<void> stopListening();
}

@LazySingleton(as : SpeechToTextRepo)
class SpeechToTextRepoImpl implements SpeechToTextRepo {
  final SpeechToText _speechToText;

  SpeechToTextRepoImpl({required SpeechToText speechToText})
      : _speechToText = speechToText ;


  @override
  Future<bool> init() async{
    return await _speechToText.initialize();
  }

  @override
  Future<void> startListening(void Function(String words) onResult) async {
    if (await _speechToText.hasPermission && _speechToText.isNotListening) {
      await _speechToText.listen(
        onResult: (result) => onResult(result.recognizedWords),
        listenOptions: SpeechListenOptions(partialResults: true)
      );
    }
  }

  @override
  Future<void> stopListening() async{
    if(await _speechToText.isListening) {
      _speechToText.stop();
    }
  }

}