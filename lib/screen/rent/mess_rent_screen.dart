import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MessRentScreen extends StatefulWidget {
  const MessRentScreen({super.key});

  @override
  State<MessRentScreen> createState() => _MessRentScreenState();
}

class _MessRentScreenState extends State<MessRentScreen> {
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
      'upazilla': 'বালিয়াডাঙ্গী',
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

  // List of upazillas for filtering
  final List<String> upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  // Selected upazilla for filtering
  String? selectedUpazilla;

  // Function to launch phone call
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunch(launchUri.toString())) {
      await launch(launchUri.toString());
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  // Function to show details in a bottom modal sheet
  void _showHouseDetails(BuildContext context, Map<String, dynamic> house) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                house['name'],
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                house['location'],
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'যোগাযোগঃ ${house['phone']}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                house['price'],
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                house['description'],
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _makePhoneCall(house['phone']),
                    icon: const Icon(Icons.call),
                    label: const Text('কল করুন'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                    label: const Text('বন্ধ করুন'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
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
        );
      },
    );
  }

  // Function to show filter bottom sheet
  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...upazillas.map((upazilla) {
                return ListTile(
                  title: Text(upazilla),
                  onTap: () {
                    setState(() {
                      selectedUpazilla = upazilla;
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  trailing: selectedUpazilla == upazilla
                      ? const Icon(Icons.check, color: Colors.teal)
                      : null,
                );
              }),
              const SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedUpazilla = null; // Clear filter
                    });
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ফিল্টার সরান'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Filter houses based on selected upazilla
    final filteredHouses = selectedUpazilla == null
        ? houses
        : houses.where((house) => house['upazilla'] == selectedUpazilla).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('মেস ভাড়া'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: filteredHouses.length,
        itemBuilder: (context, index) {
          final house = filteredHouses[index];
          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        house['location'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            house['price'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => _showHouseDetails(context, house),
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
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }
}