import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../data/repo/open_ai_repo.dart';
import 'open_ai_state.dart';

@injectable
class OpenAiCubit extends Cubit<OpenAiState> {
  final OpenAiRepo _openAiRepo;

  OpenAiCubit(this._openAiRepo) : super(const OpenAiState());

  Future<void> processPrompt(String prompt) async {
    if (prompt.trim().isEmpty)
      return;
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final result = await _openAiRepo.processPrompt(prompt);

      final isImageUrl = result.startsWith('http');

      emit(state.copyWith(
        response: result,
        isImage: isImageUrl,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> getChatResponse(String prompt) async {
    if (prompt.trim().isEmpty)
      return;
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _openAiRepo.getChatResponse(prompt);

      emit(state.copyWith(
        response: result,
        isImage: false,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  Future<void> generateImage(String prompt) async {
    if (prompt.trim().isEmpty)
      return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final result = await _openAiRepo.generateImage(prompt);

      emit(state.copyWith(
        response: result,
        isImage: true,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }
}