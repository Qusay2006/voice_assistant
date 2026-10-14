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
    FeatureBox(pallete: Pallete.firstSuggestionBoxColor,title: "Gemini",subtitle: 'A smarter way to stay organized and informed with Gemini',),
    FeatureBox(pallete: Pallete.secondSuggestionBoxColor,title: "Generated Image",subtitle: 'Get inspired and stay creative with your personal assistant powered by Generative AI',),
    FeatureBox(pallete: Pallete.thirdSuggestionBoxColor,title: "Smart Voice Assistant",subtitle: 'Get the best of both with a voice assistant powered by Dall-E and gemini',)
    ],),
      ]);

  }
}
