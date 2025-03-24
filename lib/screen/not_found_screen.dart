import 'package:flutter/material.dart';
import 'package:thakurgaon/utils/app_routes.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            const Text('Oops! The page you are looking for doesn\'t exist.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18)),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, Routes.home),
              child: const Text('Go to Home')
            )
          ],
        ),
      ),
    );
  }
}