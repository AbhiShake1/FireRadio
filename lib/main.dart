import 'package:fire_radio/page/home_page.dart';
import 'package:fire_radio/util/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  //
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //themeMode: ThemeMode.system,
      //theme: AppThemes.light(context),
      //darkTheme: AppThemes.dark(context),
      home: HomePage(),
    );
  }
}
