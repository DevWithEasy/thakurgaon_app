import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/utils/app_routes.dart';
import '../../provider/app_provider.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final appBarColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final appBarTextColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Page Not Found',
          style: TextStyle(color: appBarTextColor),
        ),
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(color: appBarTextColor),
      ),
      backgroundColor: bgColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red[400], // Slightly lighter red in dark mode
            ),
            const SizedBox(height: 20),
            Text(
              'Oops! The page you are looking for doesn\'t exist.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: isDarkMode ? Colors.teal[700] : Colors.teal,
                foregroundColor: Colors.white,
              ),
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}