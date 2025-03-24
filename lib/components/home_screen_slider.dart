import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';

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
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final textBgOpacity = isDarkMode ? 0.7 : 0.5; // Darker overlay in dark mode

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDarkMode
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 6,
                  spreadRadius: 1,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      ),
      child: SizedBox(
        height: 200,
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
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    images[index]['image'],
                    fit: BoxFit.cover,
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.2)
                        : null, // Slightly darken images in dark mode
                    colorBlendMode: BlendMode.darken,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(textBgOpacity),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12),
                        ),
                      ),
                      child: Text(
                        images[index]['title'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          shadows: isDarkMode
                              ? [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.5),
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  )
                                ]
                              : null,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  // Add dark mode indicator dots
                  Positioned(
                    bottom: 40,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        images.length,
                        (i) => Container(
                          width: 8,
                          height: 8,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == i
                                ? isDarkMode ? Colors.teal[200]! : Colors.teal
                                : Colors.white.withOpacity(0.5),
                          ),
                        ),
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