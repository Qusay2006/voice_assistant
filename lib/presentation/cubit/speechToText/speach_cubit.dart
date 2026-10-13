import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:voice_assistant/data/repo/speech_to_text.dart';
import 'package:voice_assistant/presentation/cubit/speechToText/speach_state.dart';

@injectable
class SpeachCubit extends Cubit<SpeachState>{
  final SpeechToTextRepo _speach;
  SpeachCubit({required SpeechToTextRepo speach})
      :_speach = speach ,super(const SpeachState());

  Future<void> start() async {
    if (!state.permission) {
      await initializing();
      if (!state.permission) {
        return;
      }
    }
    emit(state.copyWith(isListening: true, permission: true, error: null));
    await _speach.startListening(onSpeechResult);
  }

  void onSpeechResult(String words){
    emit(state.copyWith(words: words));
  }

  Future<void> stop() async {
    await _speach.stopListening();
    emit(state.copyWith(isListening: false));
  }

  Future<void> initializing() async {
    final isTrue = await _speach.init(
      onStatus: _onStatus,   // ← جديد
      onError: _onError,     // ← جديد
    );
    if (isClosed) return;
    isTrue
        ? emit(state.copyWith(permission: true))
        : emit(state.copyWith(
        permission: false,
        error: 'Microphone permission denied or not available'));
  }

  // ← جديد: المكتبة بتناديها لما تتغير حالتها
  void _onStatus(String status) {
    if (isClosed) return;
    // 'done' = خلصت، حتى لو وقفت لحالها بسبب الصمت
    if (status == 'done' && state.isListening) {
      emit(state.copyWith(isListening: false));
    }
  }

  // ← جديد: المكتبة بتناديها لما يصير خطأ
  void _onError(String message) {
    if (isClosed) return;
    emit(state.copyWith(isListening: false, error: message));
  }
}