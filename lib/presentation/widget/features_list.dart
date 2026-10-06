import 'package:flutter/cupertino.dart';

import '../../core/them/pallete.dart';
import 'feature_box.dart';

class FeaturesList extends StatelessWidget {

  const FeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 13),
          alignment: AlignmentGeometry.centerLeft,
          child: Text('Here are few features',style: TextStyle(
              color: Pallete.mainFontColor,
              fontFamily: 'Cer Pro',
              fontSize: 20,
              fontWeight: FontWeight.bold)),

    ),
    Column(children: [
    FeatureBox(pallete: Pallete.firstSuggestionBoxColor,title: "ChatGPT",subtitle: 'A smarter way to stay organized and informed with ChatGPT',),
    FeatureBox(pallete: Pallete.secondSuggestionBoxColor,title: "Dall-E",subtitle: 'Get inspired and stay creative with your personal assistant powered by Dall-E',),
    FeatureBox(pallete: Pallete.thirdSuggestionBoxColor,title: "Smart Voice Assistant",subtitle: 'Get the best of both with a voice assistant powered by Dall-E and ChatGPT',)
    ],),
      ]);

  }
}
