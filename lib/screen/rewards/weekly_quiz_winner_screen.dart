import 'package:flutter/material.dart';

class WeeklyQuizWinnerScreen extends StatefulWidget {
  const WeeklyQuizWinnerScreen({super.key});

  @override
  State<WeeklyQuizWinnerScreen> createState() => _WeeklyQuizWinnerScreenState();
}

class _WeeklyQuizWinnerScreenState extends State<WeeklyQuizWinnerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weekly Quiz Winner'),
      ),
      body: Center(
        child: Text('Congratulations! You are the Weekly Quiz Winner!'),
      )
    );
  }
}