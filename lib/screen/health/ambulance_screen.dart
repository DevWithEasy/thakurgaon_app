import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/app_provider.dart';

class AmbulanceScreen extends StatefulWidget {
  const AmbulanceScreen({super.key});

  @override
  State<AmbulanceScreen> createState() => _AmbulanceScreenState();
}

class _AmbulanceScreenState extends State<AmbulanceScreen> {
  // Demo data for ambulances
  final List<Map<String, String>> ambulances = [
    {
      'name': 'ঢাকা এম্বুল্যান্স সার্ভিস',
      'phone': '01712345678',
      'location': 'ঢাকা, বাংলাদেশ',
      'upazilla': 'ঠাকুরগাঁও সদর',
    },
    {
      'name': 'চট্টগ্রাম এম্বুল্যান্স সার্ভিস',
      'phone': '01898765432',
      'location': 'চট্টগ্রাম, বাংলাদেশ',
      'upazilla': 'পীরগঞ্জ',
    },
    {
      'name': 'রাজশাহী এম্বুল্যান্স সার্ভিস',
      'phone': '01911223344',
      'location': 'রাজশাহী, বাংলাদেশ',
      'upazilla': 'রাণীশংকৈল',
    },
    {
      'name': 'খুলনা এম্বুল্যান্স সার্ভিস',
      'phone': '01655667788',
      'location': 'খুলনা, বাংলাদেশ',
      'upazilla': 'বালিয়াডাঙ্গী',
    },
    {
      'name': 'সিলেট এম্বুল্যান্স সার্ভিস',
      'phone': '01512345678',
      'location': 'সিলেট, বাংলাদেশ',
      'upazilla': 'হরিপুর',
    },
  ];

  // List of unique upazillas for filtering
  final List<String> upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  // Selected upazilla for filtering
  String? selectedUpazilla;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final filteredAmbulances = selectedUpazilla == null
        ? ambulances
        : ambulances.where((a) => a['upazilla'] == selectedUpazilla).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'এম্বুল্যান্স তালিকা',
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
      body: filteredAmbulances.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.airport_shuttle,
                    size: 60,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'কোন এম্বুল্যান্স পাওয়া যায়নি',
                    style: TextStyle(
                      fontSize: 18,
                      color: isDarkMode ? Colors.white70 : Colors.black54,
                    ),
                  ),
                  if (selectedUpazilla != null)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selectedUpazilla = null;
                        });
                      },
                      child: const Text('ফিল্টার সরান'),
                    ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: filteredAmbulances.length,
              itemBuilder: (context, index) {
                final ambulance = filteredAmbulances[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 2,
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 40,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ambulance['name']!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'যোগাযোগ: ${ambulance['phone']}',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                                ),
                              ),
                              Text(
                                'অবস্থান: ${ambulance['location']}',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.white70 : Colors.grey.shade700,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'উপজেলা: ${ambulance['upazilla']}',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => _makePhoneCall(ambulance['phone']!),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.teal, Colors.teal.shade700],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('কল করতে ব্যর্থ হয়েছে'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context, listen: false).themeMode == ThemeMode.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[900] : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey[700] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(
                'ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: upazillas.length,
                  itemBuilder: (context, index) {
                    final upazilla = upazillas[index];
                    return ListTile(
                      title: Text(
                        upazilla,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      trailing: selectedUpazilla == upazilla
                          ? Icon(Icons.check, color: Colors.teal)
                          : null,
                      onTap: () {
                        setState(() {
                          selectedUpazilla = upazilla;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedUpazilla = null;
                    });
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'সব ফিল্টার সরান',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}