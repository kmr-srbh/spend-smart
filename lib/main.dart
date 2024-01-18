import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'package:spend_smart/models/expense.dart';
import 'package:spend_smart/widgets/route_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory();
  Hive
    ..init(appDocumentsDirectory.path)
    ..registerAdapter(ExpenseAdapter())
    ..registerAdapter(CategoryAdapter())
    ..registerAdapter(TimeOfDayAdapter());

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void dispose() {
    Hive.box('expenses').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => AnnotatedRegion(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: isDarkMode
              ? (darkDynamic?.background ??
                  ThemeData.dark().colorScheme.background)
              : (lightDynamic?.background ??
                  ThemeData.light().colorScheme.background),
        ),
        child: MaterialApp(
          home: FutureBuilder(
            future: Hive.openBox('expenses'),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const RouteManager();
                }
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                );
              }
            },
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
