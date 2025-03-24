import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/food_hotel_model.dart';
import '../../utils/app_utils.dart';
import '../../provider/app_provider.dart';

class FoodHotelScreen extends StatefulWidget {
  const FoodHotelScreen({super.key});

  @override
  State<FoodHotelScreen> createState() => _FoodHotelScreenState();
}

class _FoodHotelScreenState extends State<FoodHotelScreen> {
  List<FoodHotel> allRestaurants = [];
  List<FoodHotel> filteredRestaurants = [];
  String searchQuery = '';
  String? appliedUpazilla;
  
  final List<String> upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    try {
      List<FoodHotel> data = await AppUtils.foodHotels();
      setState(() {
        allRestaurants = data;
        filteredRestaurants = data;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load data: $error')));
      }
    }
  }

  void _updateFilteredList() {
    setState(() {
      filteredRestaurants = allRestaurants.where((restaurant) {
        final matchesName =
            restaurant.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesUpazilla =
            appliedUpazilla == null || restaurant.upazilla == appliedUpazilla;
        return matchesName && matchesUpazilla;
      }).toList();
    });
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not make a call to $phoneNumber')));
    }
  }

  void _openFilterModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      // Get the theme mode inside the builder
      final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
      
      return Container(
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[800] : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'ফিল্টার করুন',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: upazillas.map((upazilla) {
                bool isSelected = appliedUpazilla == upazilla;
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      appliedUpazilla = isSelected ? null : upazilla;
                    });
                    Navigator.pop(context);
                    _updateFilteredList();
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0.5,
                    backgroundColor: isSelected
                        ? Colors.teal
                        : (isDarkMode ? Colors.grey[700] : Colors.grey.shade50),
                    foregroundColor: isSelected
                        ? Colors.white
                        : (isDarkMode ? Colors.white : Colors.teal),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8),
                  ),
                  child: Text(
                    upazilla,
                    style: TextStyle(
                      fontSize: 14,
                      color: isSelected
                          ? Colors.white
                          : (isDarkMode ? Colors.white : Colors.teal),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  appliedUpazilla = null;
                });
                Navigator.pop(context);
                _updateFilteredList();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    'রিসেট করুন',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<AppProvider>(context).themeMode;
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Food & Hotel'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _updateFilteredList();
                });
              },
              decoration: InputDecoration(
                labelText: 'রেস্টুরেন্ট খুঁজুন',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRestaurants.length,
              itemBuilder: (context, index) {
                final restaurant = filteredRestaurants[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 1,
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      restaurant.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.teal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.restaurant,
                              size: 16,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.cuisine,
                              style: TextStyle(
                                color: isDarkMode 
                                    ? Colors.grey.shade300 
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              restaurant.location,
                              style: TextStyle(
                                color: isDarkMode 
                                    ? Colors.grey.shade300 
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 16,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Contact: ${restaurant.contact}',
                              style: TextStyle(
                                color: isDarkMode 
                                    ? Colors.grey.shade300 
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              size: 16,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Email: ${restaurant.email}',
                              style: TextStyle(
                                color: isDarkMode 
                                    ? Colors.grey.shade300 
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () => _makePhoneCall(restaurant.contact),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(Icons.call, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openFilterModal(context);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}