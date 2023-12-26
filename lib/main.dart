import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_color/dynamic_color.dart';

import 'package:spend_smart/widgets/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainApp();
}

class _MainApp extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: isDarkMode
              ? ThemeData.dark().scaffoldBackgroundColor
              : ThemeData.light().scaffoldBackgroundColor,
        ),
        child: MaterialApp(
          home: const Scaffold(
            body: Home(),
          ),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              colorScheme: lightDynamic ?? ThemeData.light().colorScheme),
          darkTheme: ThemeData(
              colorScheme: darkDynamic ?? ThemeData.dark().colorScheme),
        ),
      ),
    );
  }
}
