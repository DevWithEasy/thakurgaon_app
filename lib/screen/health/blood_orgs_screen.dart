import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/app_provider.dart';

class BloodOrgsScreen extends StatefulWidget {
  const BloodOrgsScreen({super.key});

  @override
  State<BloodOrgsScreen> createState() => _BloodOrgsScreenState();
}

class _BloodOrgsScreenState extends State<BloodOrgsScreen> {
  final List<Map<String, String>> _bloodOrgs = [
    {
      "name": "বাঁধন (BONDHON)",
      "email": "bondhon.thakurgaon@example.com",
      "phone": "+8801724588951",
    },
    {
      "name": "স্বপ্ন রক্তদান সংস্থা",
      "email": "shopnoroktodan@example.com",
      "phone": "+8801825462581",
    },
    {
      "name": "ঠাকুরগাঁও ব্লাড ব্যাংক",
      "email": "thakurgaonbloodbank@example.com",
      "phone": "+8805616458458",
    },
    {
      "name": "রেড ক্রিসেন্ট সোসাইটি (ঠাকুরগাঁও)",
      "email": "redcrescent.tg@example.com",
      "phone": "+8801945842514",
    },
    {
      "name": "রক্তবন্ধু",
      "email": "roktobondhu@example.com",
      "phone": "+8801945842514",
    },
    {
      "name": "স্বাধীন সমাজ কল্যাণ পরিষদ",
      "email": "shadinsomaj@example.com",
      "phone": "+8801945842514",
    },
    {
      "name": "ইকো সোশ্যাল ডেভলপমেন্ট অর্গানাইজেশন (ইএসডিও)",
      "email": "esdo@example.com",
      "phone": "+8801945842514",
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredOrgs = [];

  @override
  void initState() {
    super.initState();
    _filteredOrgs = _bloodOrgs;
  }

  void _filterOrgs(String query) {
    setState(() {
      _filteredOrgs = _bloodOrgs
          .where((org) =>
              org["name"]!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri: $e');
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $email';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'রক্ত সংগঠন',
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
              colors: [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterOrgs,
              decoration: InputDecoration(
                hintText: 'রক্ত সংগঠন খুঁজুন...',
                prefixIcon: Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.teal, width: 2),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.teal),
                        onPressed: () {
                          _searchController.clear();
                          _filterOrgs('');
                        },
                      )
                    : null,
                hintStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),

          // Organization List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredOrgs.length,
              itemBuilder: (context, index) {
                final org = _filteredOrgs[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Organization Name
                        Text(
                          org["name"]!,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                          ),
                        ),
                        SizedBox(height: 8),

                        // Email
                        _buildDetailRow(
                          context,
                          Icons.email, 
                          org["email"]!,
                          isDarkMode: isDarkMode,
                        ),
                        SizedBox(height: 8),

                        // Phone
                        _buildDetailRow(
                          context,
                          Icons.phone, 
                          org["phone"]!,
                          isDarkMode: isDarkMode,
                        ),
                        SizedBox(height: 16),

                        // Call and Email Buttons
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _makePhoneCall(org["phone"]!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12, 
                                  horizontal: 16,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.call, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'কল করুন',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 16),
                            ElevatedButton(
                              onPressed: () => _sendEmail(org["email"]!),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                  vertical: 12, 
                                  horizontal: 16,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.email, color: Colors.white),
                                  SizedBox(width: 8),
                                  Text(
                                    'ইমেইল করুন',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon, 
    String text, {
    required bool isDarkMode,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon, 
          size: 20, 
          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}