import 'package:flutter/cupertino.dart';

import '../../core/them/pallete.dart';

class AgentPfp extends StatelessWidget {
  const AgentPfp({super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(children: [
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
    ],);
  }
}
