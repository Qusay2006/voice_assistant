import 'package:equatable/equatable.dart';

class OpenAiState extends Equatable {
  final String response;
  final bool isImage;
  final bool isLoading;
  final String? error;

  const OpenAiState({
    this.response = '',
    this.isImage = false,
    this.isLoading = false,
    this.error,
  });

  OpenAiState copyWith({
    String? response,
    bool? isImage,
    bool? isLoading,
    String? error,
  }) {
    return OpenAiState(
      response: response ?? this.response,
      isImage: isImage ?? this.isImage,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [response, isImage, isLoading, error];
}