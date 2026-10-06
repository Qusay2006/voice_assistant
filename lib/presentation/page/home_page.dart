import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_assistant/core/injection/injection.dart';
import 'package:voice_assistant/core/them/pallete.dart';
import 'package:voice_assistant/presentation/cubit/textToSpeech/text_to_speech_cubit.dart';
import 'package:voice_assistant/presentation/widget/agent_pfp.dart';
import 'package:voice_assistant/presentation/widget/agent_text_field.dart';
import 'package:voice_assistant/presentation/widget/features_list.dart';

import '../cubit/openAi/open_ai_cubit.dart';
import '../cubit/openAi/open_ai_state.dart';
import '../cubit/speechToText/speach_cubit.dart';
import '../cubit/speechToText/speach_state.dart';
import '../widget/feature_box.dart';
import '../widget/features_list.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers : [
      BlocProvider<SpeachCubit>(create: (context) => getIt<SpeachCubit>(),),
    BlocProvider<OpenAiCubit>(create: (context) => getIt<OpenAiCubit>()),
      BlocProvider<TextToSpeechCubit>(create: (context) => getIt<TextToSpeechCubit>(),)
    ],
    child: HomePage(),);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      // Send to OpenAI
      BlocListener<SpeachCubit, SpeachState>(
        listener: (context, speachState) {
          if (!speachState.isListening && speachState.words.trim().isNotEmpty) {
            context.read<OpenAiCubit>().processPrompt(speachState.words);
          }
        },
      ),
      //response From OpenAi
      BlocListener<OpenAiCubit, OpenAiState>(
        listener: (context, openAiState) {
          if(openAiState.response.isNotEmpty&&!openAiState.isImage){
            context.read<TextToSpeechCubit>().speak(openAiState.response);
          }
        },
      ),
    ], child:
    Scaffold(appBar: AppBar(
      title: const Text("Allen"),
      leading: const Icon(Icons.menu),
      centerTitle: true,),
        body: SingleChildScrollView(
            child: Column(children: [
              // Agent Pfp
              AgentPfp(),
              // Agent TextField
              AgentTextField(),
              //features list
              BlocBuilder<OpenAiCubit, OpenAiState>(builder: (context, state) {
                if(state.response.isEmpty&&state.isLoading)
                    return const FeaturesList();
                else{
                return const SizedBox.shrink();
              }
              },)
            ])
        ),
        //mic
        floatingActionButton: BlocBuilder<SpeachCubit, SpeachState>(builder: (context, state) {
          return  FloatingActionButton(onPressed: () async {
            final cubit =await context.read<SpeachCubit>();
            if(state.permission) {
              state.isListening? cubit.stop() :cubit.start();
            }
            else {
              cubit.initializing();
            }
          },child: state.isListening? Icon(Icons.mic):Icon(Icons.mic_off),
            backgroundColor: Pallete.firstSuggestionBoxColor,);
        },)
      )
    );
  }
}