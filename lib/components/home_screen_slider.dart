import 'dart:async'; // Import for Timer

import 'package:flutter/material.dart';

class HomeScreenSlider extends StatefulWidget {
  const HomeScreenSlider({super.key});

  @override
  State<HomeScreenSlider> createState() => _HomeScreenSliderState();
}

class _HomeScreenSliderState extends State<HomeScreenSlider> {
  static List<Map<String, dynamic>> images = [
    {'title': 'অপরাজেয় একাত্তর', 'image': 'assets/images/places/opajeo_71.jpg'},
    {'title': 'ঠাকুরগাঁও ডিসি পার্ক', 'image': 'assets/images/places/dc_park.jpeg'},
    {'title': 'জামালপুর মসজিদ', 'image': 'assets/images/places/jamalpur_mosque.jpg'},
    {'title': 'লোকায়ন', 'image': 'assets/images/places/locayon.png'},
    {'title': 'জিনের মসজিদ', 'image': 'assets/images/places/old_mosque.jpg'},
    {'title': 'বড় আম গাছ', 'image': 'assets/images/places/mango_tree.jpeg'},
    {'title': 'রাজা টংকনাথের রাজবাড়ি', 'image': 'assets/images/places/raja_tonknath.jpg'},
    {'title': 'অরেঞ্জ ভ্যালি', 'image': 'assets/images/places/orange_valley.jpg'},
    {'title': 'ইস্কন মন্দির', 'image': 'assets/images/places/eskon_mandir.jpg'},
  ];

  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 200, // Adjust height as needed
        child: PageView.builder(
          controller: _pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              child: Stack(
                fit: StackFit.expand, // Ensure the stack takes full space
                children: [
                  Image.asset(
                    images[index]['image'],
                    fit:
                        BoxFit
                            .cover, // Ensure the image covers the entire space
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(
                          0.5,
                        ), // Semi-transparent background
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        images[index]['title'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
