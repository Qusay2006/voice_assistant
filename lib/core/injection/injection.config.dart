// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:speech_to_text/speech_to_text.dart' as _i941;
import 'package:voice_assistant/core/injection/register_module.dart' as _i74;
import 'package:voice_assistant/data/speach_to_text.dart' as _i253;
import 'package:voice_assistant/presintation/cubit/speach_cubit.dart' as _i1058;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i941.SpeechToText>(() => registerModule.speechToText);
    gh.lazySingleton<_i253.SpeechToTextRepo>(
      () => _i253.SpeechToTextRepoImpl(speechToText: gh<_i941.SpeechToText>()),
    );
    gh.factory<_i1058.SpeachCubit>(
      () => _i1058.SpeachCubit(speach: gh<_i253.SpeechToTextRepo>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i74.RegisterModule {}
