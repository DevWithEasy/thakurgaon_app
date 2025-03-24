import 'package:flutter/material.dart';

class TrainSheduleScreen extends StatefulWidget {
  const TrainSheduleScreen({super.key});

  @override
  State<TrainSheduleScreen> createState() => _TrainSheduleScreenState();
}

class _TrainSheduleScreenState extends State<TrainSheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Train Schedule'),
      ),
    );
  }
}