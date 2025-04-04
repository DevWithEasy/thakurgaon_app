import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/tourist_place_model.dart';
import 'package:thakurgaon/provider/app_provider.dart';

class PlaceScreen extends StatefulWidget {
  const PlaceScreen({super.key});

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  late int _currentIndex;
  late List<TouristPlace> _places;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _currentIndex = args['index'];
    _places = args['places'];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _places[_currentIndex].name,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.teal.shade800, Colors.teal.shade900]
                  : [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: PageView.builder(
          itemCount: _places.length,
          controller: PageController(initialPage: _currentIndex),
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            final place = _places[index];
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Image
                  Hero(
                    tag: '${place.name}_${place.image}',
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      child: Image.asset(
                        place.image,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Place Name
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      place.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.teal.shade200 : Colors.teal.shade700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Place Description
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      place.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                        fontFamily: 'kalpurush',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Location Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: isDarkMode ? 0 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: RichText(
                          text: TextSpan(
                            text: 'লোকেশনঃ\n',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal.shade700,
                              fontFamily: 'kalpurush',
                            ),
                            children: [
                              TextSpan(
                                text: place.location.isNotEmpty
                                    ? place.location
                                    : 'এই বিষয়ে তথ্য যোগ করা হয়নি।',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                                  fontFamily: 'kalpurush',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // How to Reach Section
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Card(
                      elevation: isDarkMode ? 0 : 1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: isDarkMode ? Colors.grey[800] : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: RichText(
                          text: TextSpan(
                            text: 'কিভাবে যাবেনঃ\n',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal.shade700,
                              fontFamily: 'kalpurush',
                            ),
                            children: [
                              TextSpan(
                                text: place.locationFromTo.isNotEmpty
                                    ? place.locationFromTo
                                    : 'এই বিষয়ে তথ্য যোগ করা হয়নি।',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                                  fontFamily: 'kalpurush',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}