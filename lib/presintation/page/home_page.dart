import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voice_assistant/core/injection/injection.dart';
import 'package:voice_assistant/core/them/pallete.dart';
import 'package:voice_assistant/presintation/cubit/speach_cubit.dart';
import 'package:voice_assistant/presintation/cubit/speach_state.dart';
import 'package:voice_assistant/presintation/widget/feature_box.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => getIt<SpeachCubit>(),
    child: HomePage(),);
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpeachCubit, SpeachState>(
  builder: (context, state) {
    return Scaffold(appBar: AppBar(
      title: const Text("Allen"),
    leading: const Icon(Icons.menu),
    centerTitle: true,),
    body: SingleChildScrollView(
      child: Column(children: [

        // Agent Pfp
        Stack(children: [
          Center(
            child: Container(
              height: 120,width: 120,margin:const EdgeInsets.all(1) ,
              decoration:const BoxDecoration(
                color: Pallete.assistantCircleColor,
                shape: BoxShape.circle
              )
              ),
          ),
          Container(
            height: 123,decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                  image: AssetImage('lib/core/assets/images/virtualAssistant.png'))
          ),),
        ],),

        // Agent TextField
        Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10
      ),
      margin: const  EdgeInsets.symmetric(horizontal: 30).copyWith(top: 20),
      decoration: BoxDecoration(
        border: Border.all(width: 0.9,
            color: Pallete.mainFontColor,
        ),
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero)
      ),child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2,vertical: 5),
        child: Text('Good Morning, how can i help you sir?',style: TextStyle(
        color: Pallete.mainFontColor,
        fontFamily: 'Cera Pro',
        fontSize: 26
          ),),
      ) ,
        ),
         Container(
       padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 13),
       alignment: AlignmentGeometry.centerLeft,
       child: Text('Here are few features',style: TextStyle(
         color: Pallete.mainFontColor,
       fontFamily: 'Cer Pro',
       fontSize: 20,
       fontWeight: FontWeight.bold)),
         ),


      //features list
        Column(children: [
          FeatureBox(pallete: Pallete.firstSuggestionBoxColor,title: "ChatGPT",subtitle: 'A smarter way to stay organized and informed with ChatGPT',),
          FeatureBox(pallete: Pallete.secondSuggestionBoxColor,title: "Dall-E",subtitle: 'Get inspired and stay creative with your personal assistant powered by Dall-E',),
          FeatureBox(pallete: Pallete.thirdSuggestionBoxColor,title: "Smart Voice Assistant",subtitle: 'Get the best of both with a voice assistant powered by Dall-E and ChatGPT',)
        ],)
      ]),
    ),floatingActionButton:
      FloatingActionButton(onPressed: () async {
        final cubit = context.read<SpeachCubit>();
        if(state.permission) {
        state.isListening? cubit.stop() :cubit.start();
        }
        else {
          cubit.initializing();
        }
      },child: state.isListening? Icon(Icons.mic):Icon(Icons.mic_off),
      backgroundColor: Pallete.firstSuggestionBoxColor,),);
  },
);
  }
}
