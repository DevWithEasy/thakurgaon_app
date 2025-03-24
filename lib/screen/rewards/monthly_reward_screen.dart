import 'package:flutter/material.dart';

class MonthlyRewardScreen extends StatefulWidget {
  const MonthlyRewardScreen({super.key});

  @override
  State<MonthlyRewardScreen> createState() => _MonthlyRewardScreenState();
}

class _MonthlyRewardScreenState extends State<MonthlyRewardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Rewards'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Welcome to your monthly rewards dashboard!'),
            Text('Your current rewards balance is 100.00'),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}