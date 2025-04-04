import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class HouseRentScreen extends StatefulWidget {
  const HouseRentScreen({super.key});

  @override
  State<HouseRentScreen> createState() => _HouseRentScreenState();
}

class _HouseRentScreenState extends State<HouseRentScreen> {
  // Demo data for houses
  final List<Map<String, dynamic>> houses = [
    {
      'name': 'সুন্দরবন ভিলা',
      'location': 'ঢাকা, বাংলাদেশ',
      'price': '৳ ২০,০০০/মাস',
      'phone': '+8801712345678',
      'description':
          'এই সুন্দরবন ভিলাটি একটি শান্তিপূর্ণ এলাকায় অবস্থিত, যা প্রাকৃতিক সৌন্দর্যে ভরপুর। এটি ৩ বেডরুম, ২ বাথরুম এবং একটি সুসজ্জিত রান্নাঘর সহ একটি আদর্শ পরিবার বাসস্থান।',
      'image':
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=600',
      'upazilla': 'ঠাকুরগাঁও সদর',
    },
    {
      'name': 'গ্রীন ভিউ অ্যাপার্টমেন্ট',
      'location': 'চট্টগ্রাম, বাংলাদেশ',
      'price': '৳ ১৫,০০০/মাস',
      'phone': '+8801712345678',
      'description':
          'গ্রীন ভিউ অ্যাপার্টমেন্টটি একটি আধুনিক এবং আরামদায়ক আবাসিক এলাকায় অবস্থিত। এটি ২ বেডরুম, ১ বাথরুম এবং একটি স্পেসিয়াস লিভিং এরিয়া সহ একটি আদর্শ বাসস্থান।',
      'image':
          'https://images.pexels.com/photos/186077/pexels-photo-186077.jpeg?auto=compress&cs=tinysrgb&w=600',
      'upazilla': 'পীরগঞ্জ',
    },
    {
      'name': 'লেকসাইড হাউস',
      'location': 'সিলেট, বাংলাদেশ',
      'price': '৳ ২৫,০০০/মাস',
      'phone': '+8801712345678',
      'description':
          'লেকসাইড হাউসটি একটি মনোরম লেকের পাশে অবস্থিত, যা প্রাকৃতিক সৌন্দর্যে ভরপুর। এটি ৪ বেডরুম, ৩ বাথরুম এবং একটি বড় বাগান সহ একটি আদর্শ পরিবার বাসস্থান।',
      'image':
          'https://images.pexels.com/photos/1396122/pexels-photo-1396122.jpeg?auto=compress&cs=tinysrgb&w=600',
      'upazilla': 'রাণীশংকৈল',
    },
    {
      'name': 'রিভারভিউ বাসা',
      'location': 'রাজশাহী, বাংলাদেশ',
      'price': '৳ ১৮,০০০/মাস',
      'phone': '+8801712345678',
      'description':
          'রিভারভিউ বাসাটি একটি নদীর পাশে অবস্থিত, যা প্রাকৃতিক সৌন্দর্যে ভরপুর। এটি ৩ বেডরুম, ২ বাথরুম এবং একটি সুসজ্জিত রান্নাঘর সহ একটি আদর্শ পরিবার বাসস্থান।',
      'image':
          'https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=600',
      'upazilla': 'বালিয়াডাঙ্গী',
    },
    {
      'name': 'সুন্দরবন ভিলা',
      'location': 'ঢাকা, বাংলাদেশ',
      'price': '৳ ২০,০০০/মাস',
      'phone': '+8801712345678',
      'description':
          'এই সুন্দরবন ভিলাটি একটি শান্তিপূর্ণ এলাকায় অবস্থিত, যা প্রাকৃতিক সৌন্দর্যে ভরপুর। এটি ৩ বেডরুম, ২ বাথরুম এবং একটি সুসজ্জিত রান্নাঘর সহ একটি আদর্শ পরিবার বাসস্থান।',
      'image':
          'https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=600',
      'upazilla': 'হরিপুর',
    },
  ];

  // Search query
  String searchQuery = '';

  // Applied upazilla filter
  String? appliedUpazilla;

  // List of upazillas for filtering
  final List<String> upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  // Function to launch phone dialer
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not make a call to $phoneNumber')),
      );
    }
  }

  // Open filter modal
  void _openFilterModal(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
                    child: Text(upazilla),
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

  void _showHouseDetailsModal(BuildContext context, Map<String, dynamic> house) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
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
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  house['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house['location'],
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'যোগাযোগ: ${house['phone']}',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  house['price'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  house['description'],
                  style: TextStyle(
                    fontSize: 16,
                    color: isDarkMode ? Colors.grey[300] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => _makePhoneCall(house['phone']),
                      icon: Icon(Icons.call, color: Colors.white),
                      label: Text(
                        'কল করুন',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.white),
                      label: Text(
                        'বন্ধ করুন',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<AppProvider>(context).themeMode;
    final isDarkMode = themeMode == ThemeMode.dark;

    // Filter houses based on search query and applied upazilla
    final filteredHouses = houses.where((house) {
      final matchesName =
          house['name'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesUpazilla =
          appliedUpazilla == null || house['upazilla'] == appliedUpazilla;
      return matchesName && matchesUpazilla;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('বাডি ভাড়া'),
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
                });
              },
              decoration: InputDecoration(
                labelText: 'বাডি খুঁজুন',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredHouses.length,
              itemBuilder: (context, index) {
                final house = filteredHouses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 1,
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                        child: Image.network(
                          house['image'],
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              house['name'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.teal,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  size: 16,
                                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  house['location'],
                                  style: TextStyle(
                                    color: isDarkMode 
                                        ? Colors.grey[300] 
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone, 
                                  size: 16, 
                                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'যোগাযোগ: ${house['phone']}',
                                  style: TextStyle(
                                    color: isDarkMode 
                                        ? Colors.grey[300] 
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  house['price'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () => _showHouseDetailsModal(context, house),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                  ),
                                  child: const Text('বিস্তারিত'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openFilterModal(context),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}