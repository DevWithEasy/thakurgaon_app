import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
      body: ListView.builder(
        itemCount: ambulances.length,
        itemBuilder: (context, index) {
          final ambulance = ambulances[index];
          if (selectedUpazilla != null &&
              ambulance['upazilla'] != selectedUpazilla) {
            return const SizedBox.shrink();
          }

          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_hospital,
                    size: 40,
                    color: Colors.teal,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ambulance['name']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'যোগাযোগ: ${ambulance['phone']}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                        Text(
                          'অবস্থান: ${ambulance['location']}',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                  // Attractive Call Button
                  GestureDetector(
                    onTap: () => _makePhoneCall(ambulance['phone']!),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
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
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(Icons.call, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFilterBottomSheet(context);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 8,
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('কল করতে ব্যর্থ হয়েছে')));
    }
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ফিল্টার করুন',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...upazillas.map((upazilla) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      upazilla,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    trailing:
                        selectedUpazilla == upazilla
                            ? const Icon(Icons.check, color: Colors.teal)
                            : null,
                    onTap: () {
                      setState(() {
                        selectedUpazilla = upazilla;
                      });
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'ফিল্টার সরান',
                    style: TextStyle(
                      color: Colors.white,
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
