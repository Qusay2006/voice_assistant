import 'package:equatable/equatable.dart';

class SpeachState extends Equatable{
  final String words;
  final bool isListening;
  final bool permission;
  final String? error;

  const SpeachState({this.words = '',this.permission=false, this.isListening = false, this.error});

  SpeachState copyWith({String? words, bool? isListening, String? error,bool? permission}) =>
      SpeachState(
        words: words ?? this.words,
        isListening: isListening ?? this.isListening,
        error: error,
        permission: permission?? this.permission,
      );

  @override
  List<Object?> get props =>[words,isListening,permission,error] ;
}