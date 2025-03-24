// settings_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/provider/app_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode'),
            value: appProvider.themeMode == ThemeMode.dark,
            onChanged: (bool value) {
              appProvider.toggleTheme(value);
            },
          ),
          // ... other settings ...
        ],
      ),
    );
  }
}