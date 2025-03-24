import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class CarRentScreen extends StatefulWidget {
  const CarRentScreen({super.key});

  @override
  State<CarRentScreen> createState() => _CarRentScreenState();
}

class _CarRentScreenState extends State<CarRentScreen> {
  // Demo data for cars
  final List<Map<String, dynamic>> cars = [
    {
      'name': 'Toyota Corolla',
      'description':
          'টয়োটা করোলা একটি জনপ্রিয় সেডান গাড়ি, যা কম্বিনেশনে স্মুথ ড্রাইভিং এবং ফুয়েল এফিসিয়েন্সি অফার করে। এটি দৈনিক ভাড়া ৳ ২০০০।',
      'image':
          'https://images.pexels.com/photos/170811/pexels-photo-170811.jpeg?auto=compress&cs=tinysrgb&w=600',
      'price': '৳ 2000/day',
      'phone': '+8801717642515',
      'type': 'কার',
      'upazilla': 'ঠাকুরগাঁও সদর',
      'isFixedPrice': false,
    },
    {
      'name': 'Honda Civic',
      'description':
          'হোন্ডা সিভিক একটি স্টাইলিশ এবং পারফরম্যান্স-ওরিয়েন্টেড গাড়ি, যা দৈনিক ৳ ২৫০০ ভাড়ায় পাওয়া যায়। এটি শহর এবং হাইওয়ে ড্রাইভিংয়ের জন্য উপযুক্ত।',
      'image':
          'https://images.pexels.com/photos/14330171/pexels-photo-14330171.jpeg?auto=compress&cs=tinysrgb&w=600',
      'price': '৳ 2500/day',
      'phone': '+8801717642515',
      'type': 'পিকআপ',
      'upazilla': 'পীরগঞ্জ',
      'isFixedPrice': false,
    },
    {
      'name': 'Nissan Sunny',
      'description':
          'নিসান সানি একটি আরামদায়ক এবং সাশ্রয়ী গাড়ি, যা দৈনিক ৳ ১৮০০ ভাড়ায় পাওয়া যায়। এটি পরিবার এবং দৈনন্দিন ব্যবহারের জন্য আদর্শ।',
      'image':
          'https://images.pexels.com/photos/2393835/pexels-photo-2393835.jpeg?auto=compress&cs=tinysrgb&w=600',
      'price': '৳ 1800/day',
      'phone': '+8801717642515',
      'type': 'মোটর বাইক',
      'upazilla': 'রাণীশংকৈল',
      'isFixedPrice': false,
    },
    {
      'name': 'Mitsubishi Pajero',
      'description':
          'মিতসুবিশি পাজেরো একটি শক্তিশালী এসইউভি, যা দৈনিক ৳ ৩৫০০ ভাড়ায় পাওয়া যায়। এটি অফ-রোড এবং লং ড্রাইভের জন্য উপযুক্ত।',
      'image':
          'https://images.pexels.com/photos/127074/pexels-photo-127074.jpeg?auto=compress&cs=tinysrgb&w=600',
      'price': '৳ 3500/day',
      'phone': '+8801717642515',
      'type': 'ট্রাক',
      'upazilla': 'বালিয়াডাঙ্গী',
      'isFixedPrice': false,
    },
    {
      'name': 'Electric Rickshaw',
      'description':
          'ইলেকট্রিক রিকশা একটি পরিবেশবান্ধব এবং সাশ্রয়ী পরিবহন মাধ্যম, যা দৈনিক ৳ ৩৫০০ ভাড়ায় পাওয়া যায়। এটি শহরের ছোট দূরত্বের জন্য আদর্শ।',
      'image':
          'https://media.istockphoto.com/id/1195020299/photo/electric-rickshaw.jpg?b=1&s=612x612&w=0&k=20&c=Yz9Xa5-p7B25Ds8WZBWUbfLOpIn2VBL3qikI22yjtKs=',
      'price': '৳ 3500/day',
      'phone': '+8801717642515',
      'type': 'ইজি বাইক',
      'upazilla': 'হরিপুর',
      'isFixedPrice': false,
    },
  ];

  // Filter variables
  String? selectedUpazilla;
  String? selectedType;
  List<Map<String, dynamic>> filteredCars = [];

  @override
  void initState() {
    super.initState();
    filteredCars = cars;
  }

  void _applyFilters() {
    setState(() {
      filteredCars = cars.where((car) {
        bool matchesUpazilla = selectedUpazilla == null ||
            selectedUpazilla!.isEmpty ||
            car['upazilla'] == selectedUpazilla;
        bool matchesType = selectedType == null ||
            selectedType!.isEmpty ||
            car['type'] == selectedType;
        return matchesUpazilla && matchesType;
      }).toList();
    });
  }

  void _resetFilters() {
    setState(() {
      selectedUpazilla = null;
      selectedType = null;
      filteredCars = cars;
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
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
                'ফিল্টার',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),

              // Upazilla Dropdown
              Container(
                decoration: BoxDecoration(
                  gradient: isDarkMode 
                    ? LinearGradient(
                        colors: [Colors.grey[700]!, Colors.grey[800]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Colors.teal.shade50, Colors.blue.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[600]! : Colors.teal.shade200, 
                    width: 1
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: selectedUpazilla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'উপজেলা',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.teal,
                    ),
                  ),
                  items: [
                    'ঠাকুরগাঁও সদর',
                    'পীরগঞ্জ',
                    'রাণীশংকৈল',
                    'বালিয়াডাঙ্গী',
                    'হরিপুর'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUpazilla = value;
                    });
                  },
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  icon: Icon(
                    Icons.arrow_drop_down, 
                    color: isDarkMode ? Colors.grey[300] : Colors.teal
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Type Dropdown
              Container(
                decoration: BoxDecoration(
                  gradient: isDarkMode 
                    ? LinearGradient(
                        colors: [Colors.grey[700]!, Colors.grey[800]!],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : LinearGradient(
                        colors: [Colors.teal.shade50, Colors.blue.shade50],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDarkMode ? Colors.grey[600]! : Colors.teal.shade200, 
                    width: 1
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'গাড়ির ধরন',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.grey[300] : Colors.teal,
                    ),
                  ),
                  items: ['কার', 'মোটর বাইক', 'ট্রাক', 'পিকআপ', 'ইজি বাইক'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  icon: Icon(
                    Icons.arrow_drop_down, 
                    color: isDarkMode ? Colors.grey[300] : Colors.teal
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  // Search Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _applyFilters();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8),
                          const Text(
                            'খুঁজুন',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Reset Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _resetFilters();
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
                          const Icon(Icons.refresh, color: Colors.white),
                          const SizedBox(width: 8),
                          const Text(
                            'রিসেট করুন',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showCarDetailsModal(BuildContext context, Map<String, dynamic> car) {
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['name'],
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.teal,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  car['price'],
                  style: TextStyle(
                    fontSize: 18,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  car['description'],
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
                      onPressed: () {
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: car['phone'],
                        );
                        launchUrl(launchUri);
                      },
                      icon: const Icon(Icons.call, color: Colors.white),
                      label: const Text(
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
                      icon: const Icon(Icons.close, color: Colors.white),
                      label: const Text(
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('কার ভাড়া'),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.75,
        ),
        padding: const EdgeInsets.all(10),
        itemCount: filteredCars.length,
        itemBuilder: (context, index) {
          final car = filteredCars[index];
          return Card(
            elevation: 1,
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    car['image'],
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car['name'],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        car['price'],
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => _showCarDetailsModal(context, car),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'ভাড়া করুন',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                          ),
                        ),
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
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}