import 'package:flutter/material.dart';

import 'package:hive/hive.dart';
import 'package:spend_smart/data_manager.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  Box appBox = DataManager().expenseBox;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (buildContext, index) => const ListTile(
          title: Text('Setting 1'),
        ),
      ),
    );
  }
}
