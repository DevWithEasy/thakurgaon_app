import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapviewScreen extends StatefulWidget {
  const MapviewScreen({super.key});

  @override
  State<MapviewScreen> createState() => _MapviewScreenState();
}

class _MapviewScreenState extends State<MapviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('জেলার ম্যাপ'),
      ),
      body: PhotoView(
        imageProvider: const AssetImage('assets/images/district_info/thakurgaon_map_white.png'),
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 2.0,
        initialScale: PhotoViewComputedScale.contained,
        backgroundDecoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
    );
  }
}