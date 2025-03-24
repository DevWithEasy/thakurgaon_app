import 'package:flutter/material.dart';

class BusServiceScreen extends StatefulWidget {
  const BusServiceScreen({super.key});

  @override
  State<BusServiceScreen> createState() => _BusServiceScreenState();
}

class _BusServiceScreenState extends State<BusServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Service'),
      ),
      body: Center(
        child: Text('Welcome to the Bus Service!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
        },
        child: Icon(Icons.add),
      ),
    );
  }
}