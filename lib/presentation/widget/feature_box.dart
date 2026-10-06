import 'package:flutter/material.dart';
import 'package:voice_assistant/core/them/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color _pallete;
  final String _title;
  final String _subtitle;

  const FeatureBox({super.key, required this._pallete, required this._title, required this._subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      child: ListTile(
       title: Text(_title,style: TextStyle(
           fontFamily: "Cera Pro",
           fontSize: 25,
       fontWeight:  FontWeight.bold)),
        subtitle:Text(_subtitle,style: TextStyle(
          color: Pallete.blackColor,
          fontSize: 17,
          fontFamily: 'Cera Pro'
        ),),),
      decoration: BoxDecoration(
        color: _pallete,
        borderRadius: BorderRadius.circular(20).copyWith(topLeft: Radius.zero)
      ),
    );

  }
}
