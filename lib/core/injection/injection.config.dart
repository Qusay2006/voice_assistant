// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:flutter_tts/flutter_tts.dart' as _i50;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:speech_to_text/speech_to_text.dart' as _i941;
import 'package:voice_assistant/core/injection/register_module.dart' as _i74;
import 'package:voice_assistant/data/data/open_ai_data.dart' as _i531;
import 'package:voice_assistant/data/repo/open_ai_repo.dart' as _i812;
import 'package:voice_assistant/data/repo/speech_to_text.dart' as _i865;
import 'package:voice_assistant/data/repo/text_to_speech.dart' as _i396;
import 'package:voice_assistant/presentation/cubit/openAi/open_ai_cubit.dart'
    as _i838;
import 'package:voice_assistant/presentation/cubit/speechToText/speach_cubit.dart'
    as _i1027;
import 'package:voice_assistant/presentation/cubit/textToSpeech/text_to_speech_cubit.dart'
    as _i773;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i941.SpeechToText>(() => registerModule.speechToText);
    gh.lazySingleton<_i50.FlutterTts>(() => registerModule.flutterTts);
    gh.lazySingleton<_i865.SpeechToTextRepo>(
      () => _i865.SpeechToTextRepoImpl(speechToText: gh<_i941.SpeechToText>()),
    );
    gh.lazySingleton<_i531.OpenAiData>(
      () => _i531.OpenAiDataImpl(dio: gh<_i361.Dio>()),
    );
    gh.factory<_i1027.SpeachCubit>(
      () => _i1027.SpeachCubit(speach: gh<_i865.SpeechToTextRepo>()),
    );
    gh.lazySingleton<_i396.TextToSpeechRepo>(
      () => _i396.TextToSpeechRepoImpl(textToSpeech: gh<_i50.FlutterTts>()),
    );
    gh.lazySingleton<_i812.OpenAiRepo>(
      () => _i812.OpenAiRepoImpl(openAiData: gh<_i531.OpenAiData>()),
    );
    gh.factory<_i773.TextToSpeechCubit>(
      () => _i773.TextToSpeechCubit(gh<_i396.TextToSpeechRepo>()),
    );
    gh.factory<_i838.OpenAiCubit>(
      () => _i838.OpenAiCubit(gh<_i812.OpenAiRepo>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i74.RegisterModule {}
