import 'package:flutter/material.dart';

class HomeopathyScreen extends StatefulWidget {
  const HomeopathyScreen({super.key});

  @override
  State<HomeopathyScreen> createState() => _HomeopathyScreenState();
}

class _HomeopathyScreenState extends State<HomeopathyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('homeostic screen'),
      ),
    );
  }
}