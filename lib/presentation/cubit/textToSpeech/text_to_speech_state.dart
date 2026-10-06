import 'package:equatable/equatable.dart';

class TextToSpeechState extends Equatable {
  final String currentText;
  final bool isSpeaking;
  final bool isInitialized;
  final String? error;

  const TextToSpeechState({this.currentText = '', this.isSpeaking = false, this.isInitialized = false, this.error,
  });

  TextToSpeechState copyWith({String? currentText, bool? isSpeaking, bool? isInitialized, String? error,
  }) {
    return TextToSpeechState(
      currentText: currentText ?? this.currentText,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      isInitialized: isInitialized ?? this.isInitialized,
      error: error,
    );
  }
  @override
  List<Object?> get props => [currentText, isSpeaking, isInitialized, error];
}
