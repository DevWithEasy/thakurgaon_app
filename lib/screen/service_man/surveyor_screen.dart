import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/surveyor_model.dart'; // Assuming you have a Surveyor model class
import '../../utils/app_utils.dart'; // Assuming AppUtils loads JSON data

class SurveyorScreen extends StatefulWidget {
  const SurveyorScreen({super.key});

  @override
  State<SurveyorScreen> createState() => _SurveyorScreenState();
}

class _SurveyorScreenState extends State<SurveyorScreen> {
  // List of all surveyors
  List<Surveyor> allSurveyors = [];
  List<Surveyor> filteredSurveyors = [];

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

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Load surveyor data using AppUtils
  void _loadData() async {
    try {
      // Fetch all surveyors from JSON using AppUtils
      List<Surveyor> data = await AppUtils.surveyors();

      setState(() {
        allSurveyors = data;
        filteredSurveyors = data; // Initially show all surveyors
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to load data: $error')));
      }
    }
  }

  // Update filtered list based on search query and upazilla filter
  void _updateFilteredList() {
    setState(() {
      filteredSurveyors = allSurveyors.where((surveyor) {
        // Match search query
        final matchesName =
            surveyor.name.toLowerCase().contains(searchQuery.toLowerCase());

        // Match selected upazilla
        final matchesUpazilla =
            appliedUpazilla == null || surveyor.upazilla == appliedUpazilla;

        return matchesName && matchesUpazilla;
      }).toList();
    });
  }

  // Function to launch phone dialer
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not make a call to $phoneNumber')));
    }
  }

  // Open filter modal
  void _openFilterModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
              // Header
              Text(
                'ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              // Upazilla Buttons
              Wrap(
                spacing: 8.0, // Horizontal spacing between buttons
                runSpacing: 8.0, // Vertical spacing between buttons
                children: upazillas.map((upazilla) {
                  bool isSelected = appliedUpazilla == upazilla;
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        appliedUpazilla =
                            isSelected ? null : upazilla; // Toggle selection
                      });
                      Navigator.pop(context); // Close the bottom sheet
                      _updateFilteredList(); // Update filtered list
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.5,
                      backgroundColor:
                          isSelected ? Colors.teal : Colors.grey.shade50,
                      foregroundColor:
                          isSelected ? Colors.white : Colors.teal,
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
              // Reset Button
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    appliedUpazilla = null; // Clear applied upazilla
                  });
                  Navigator.pop(context); // Close the bottom sheet
                  _updateFilteredList(); // Update filtered list
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Surveyor Control'),
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _updateFilteredList(); // Update filtered list
                });
              },
              decoration: InputDecoration(
                labelText: 'সার্ভেয়ার খুঁজুন',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.teal.shade50,
              ),
            ),
          ),

          // Surveyor List
          Expanded(
            child: ListView.builder(
              itemCount: filteredSurveyors.length,
              itemBuilder: (context, index) {
                final surveyor = filteredSurveyors[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      surveyor.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.work,
                              size: 16,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              surveyor.specialization,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on, size: 16, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(
                              surveyor.location,
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.phone, size: 16, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(
                              'Contact: ${surveyor.contact}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.email, size: 16, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(
                              'Email: ${surveyor.email}',
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: () => _makePhoneCall(surveyor.contact),
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
          _openFilterModal(context); // Open filter modal
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}