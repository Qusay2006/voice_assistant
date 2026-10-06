import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/repo/text_to_speech.dart';
import 'text_to_speech_state.dart';

@injectable
class TextToSpeechCubit extends Cubit<TextToSpeechState> {
  final TextToSpeechRepo _ttsRepo;

  TextToSpeechCubit(this._ttsRepo) : super(const TextToSpeechState());

  Future<void> initTts() async {
    try {
      await _ttsRepo.init();
      emit(state.copyWith(isInitialized: true, error: null));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> speak(String content) async {
    if (content.trim().isEmpty)
      return;

    emit(state.copyWith(
      isSpeaking: true,
      currentText: content,
      error: null,
    ));

    try {
      await _ttsRepo.speak(content);
      emit(state.copyWith(isSpeaking: false));
    } catch (e) {
      emit(state.copyWith(isSpeaking: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> stop() async {
    try {
      await _ttsRepo.stop();
      emit(state.copyWith(isSpeaking: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }
}