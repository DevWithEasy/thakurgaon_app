import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/app.dart';

import 'provider/app_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const ThakurgaonApp(),
    ),
  );
}
