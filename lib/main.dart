import 'package:flutter/material.dart';

import 'package:dynamic_color/dynamic_color.dart';

import 'package:spend_smart/widgets/home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        home: const Scaffold(
          body: Home(),
        ),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: lightDynamic ?? ThemeData.light().colorScheme),
        darkTheme:
            ThemeData(colorScheme: darkDynamic ?? ThemeData.dark().colorScheme),
      ),
    );
  }
}
