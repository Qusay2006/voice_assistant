import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract interface class SpeechToTextRepo {
  Future<bool> init({void Function(String status)? onStatus, void Function(String error)? onError,
  });
  Future<void> startListening(void Function(String words) onResult);
  Future<void> stopListening();
}

@LazySingleton(as : SpeechToTextRepo)
class SpeechToTextRepoImpl implements SpeechToTextRepo {
  final SpeechToText _speechToText;

  SpeechToTextRepoImpl({required SpeechToText speechToText})
      : _speechToText = speechToText ;


  @override
  Future<bool> init({void Function(String status)? onStatus, void Function(String error)? onError,}) async {
    return await _speechToText.initialize(
      //لحتى نعرف الحالة اذا عم نسمع او لا
      onStatus: onStatus,
      onError: (e) => onError?.call(e.errorMsg),
    );
  }

  @override
  Future<void> startListening(void Function(String words) onResult) async {
    if (await _speechToText.hasPermission && _speechToText.isNotListening) {
      await _speechToText.listen(
        onResult: (result) => onResult(result.recognizedWords),
        // مشان ينكتب حكينا اول بأول ما يستنا ليخلص حكينا لحتى ينكتب
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