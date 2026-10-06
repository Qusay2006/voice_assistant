import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/them/pallete.dart';
import '../cubit/openAi/open_ai_cubit.dart';
import '../cubit/openAi/open_ai_state.dart';
import '../cubit/speechToText/speach_cubit.dart';
import '../cubit/speechToText/speach_state.dart';

class AgentTextField extends StatelessWidget {
  const AgentTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OpenAiCubit, OpenAiState>(
      builder: (context, openAiState) {
        return BlocBuilder<SpeachCubit, SpeachState>(
          builder: (context, speachState) {
            if (openAiState.isImage && openAiState.response.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    openAiState.response,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }

            String displayText = 'Good Morning, how can I help you sir?';

            if (speachState.isListening && speachState.words.isNotEmpty) {
              displayText = speachState.words;
            } else if (openAiState.isLoading) {
              displayText = 'Thinking...';
            } else if (openAiState.response.isNotEmpty) {
              displayText = openAiState.response;
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.9,
                  color: Pallete.mainFontColor,
                ),
                borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
                child: Text(
                  displayText,
                  style: const TextStyle(
                    color: Pallete.mainFontColor,
                    fontFamily: 'Cera Pro',
                    fontSize: 26,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}