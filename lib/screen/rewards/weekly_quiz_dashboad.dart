import 'package:flutter/material.dart';

class WeeklyQuizDashboad extends StatefulWidget {
  const WeeklyQuizDashboad({super.key});

  @override
  State<WeeklyQuizDashboad> createState() => _WeeklyQuizDashboadState();
}

class _WeeklyQuizDashboadState extends State<WeeklyQuizDashboad> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('সাপ্তাহিক কুইজের ড্যাশবোর্ড'),
      ),
      body: Center(
        child: Text('This is the Weekly Quiz Dashboard'),
      )
    );
  }
}