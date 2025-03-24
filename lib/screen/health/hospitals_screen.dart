import 'package:flutter/material.dart';
import 'package:thakurgaon/model/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/app_utils.dart';

class HospitalsScreen extends StatefulWidget {
  const HospitalsScreen({super.key});

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  List<Hospital> _hospitals = [];
  List<Hospital> _filteredHospitals = [];
  final TextEditingController _searchController = TextEditingController();

  // Upazilla filter state
  final List<String> _upazillas = [
    "ঠাকুরগাঁও সদর",
    "পীরগঞ্জ",
    "রাণীশংকৈল",
    "বালিয়াডাঙ্গী",
    "হরিপুর"
  ];
  final Set<String> _selectedUpazillas = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final hospitals = await AppUtils.hospitals('hospital');
    setState(() {
      _hospitals = hospitals;
      _filteredHospitals = hospitals;
    });
  }

  void _filterHospitals(String query) {
    setState(() {
      _filteredHospitals = _hospitals.where((hospital) {
        final hospitalName = hospital.name.toLowerCase();
        final input = query.toLowerCase();
        return hospitalName.contains(input);
      }).toList();
    });
  }

  void _applyFilters() {
    setState(() {
      if (_selectedUpazillas.isEmpty) {
        _filteredHospitals = _hospitals;
      } else {
        _filteredHospitals = _hospitals
            .where((hospital) => _selectedUpazillas.contains(hospital.upazilla))
            .toList();
      }
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
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
                  SizedBox(height: 16),

                  // Upazilla Checkboxes
                  ..._upazillas.map((upazilla) {
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 4),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          upazilla,
                          style: TextStyle(fontSize: 16),
                        ),
                        value: _selectedUpazillas.contains(upazilla),
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              _selectedUpazillas.add(upazilla);
                            } else {
                              _selectedUpazillas.remove(upazilla);
                            }
                          });
                        },
                        activeColor: Colors.teal,
                        checkColor: Colors.white,
                        tileColor: Colors.teal.shade50,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }),
                  SizedBox(height: 20),

                  // Apply Filter Button
                  ElevatedButton(
                    onPressed: () {
                      _applyFilters();
                      Navigator.pop(context); // Close the bottom sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    ),
                    child: Text(
                      'ফিল্টার প্রয়োগ করুন',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  _makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ফোন কল শুরু করা যায়নি: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'হাসপাতাল',
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
              onChanged: _filterHospitals,
              decoration: InputDecoration(
                labelText: 'হাসপাতালের নামে খুঁজুন',
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
                fillColor: Colors.teal.shade50,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.teal),
                        onPressed: () {
                          _searchController.clear();
                          _filterHospitals('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Hospital List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = _filteredHospitals[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/hospital-details',
                        arguments: hospital,
                      );
                    },
                    title: Text(
                      hospital.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4),
                        _buildDetailRow(Icons.location_on, hospital.address),
                        SizedBox(height: 4),
                        _buildDetailRow(Icons.phone, hospital.contact.join(", ")),
                        SizedBox(height: 4),
                        _buildDetailRow(Icons.email, hospital.email),
                      ],
                    ),
                    trailing: GestureDetector(
                      onTap: hospital.contact.isNotEmpty
                          ? () => _makePhoneCall(hospital.contact.first.toString(), context)
                          : null,
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showFilterBottomSheet,
        backgroundColor: Colors.teal,
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: Colors.teal),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
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