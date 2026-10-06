import 'package:flutter/material.dart';
import 'package:voice_assistant/core/injection/injection.dart';
import 'package:voice_assistant/core/them/pallete.dart';
import 'package:voice_assistant/presentation/page/home_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
 await DI();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: Pallete.whiteColor,
        appBarTheme: const AppBarTheme(backgroundColor: Pallete.whiteColor,
    )),
    home: const HomeProvider(),);
  }
}
