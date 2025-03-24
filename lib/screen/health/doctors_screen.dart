import 'package:flutter/material.dart';

import '../../components/doctor_card.dart';
import '../../model/doctor_model.dart';
import '../../utils/app_utils.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  String? _selectedUpazilla; // Selected upazilla for filtering

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final doctors = await AppUtils.doctors();
    setState(() {
      _doctors = doctors;
      _filteredDoctors = doctors;
    });
  }

  void _searchDoctors(String query) {
    setState(() {
      _filteredDoctors =
          _doctors.where((doctor) {
            final nameMatch = doctor.name.toLowerCase().contains(
              query.toLowerCase(),
            );
            final specializationMatch = doctor.specialization.any(
              (specialization) =>
                  specialization.toLowerCase().contains(query.toLowerCase()),
            );
            final qualificationMatch = doctor.qualifications.any(
              (qualification) =>
                  qualification.toLowerCase().contains(query.toLowerCase()),
            );
            return nameMatch || specializationMatch || qualificationMatch;
          }).toList();
    });
  }

  void _filterByUpazilla(String? upazilla) {
    setState(() {
      _selectedUpazilla = upazilla;
      if (upazilla == null || upazilla.isEmpty) {
        _filteredDoctors = _doctors; // Reset filter if no upazilla is selected
      } else {
        _filteredDoctors =
            _doctors.where((doctor) {
              return doctor.upazilla == upazilla;
            }).toList();
      }
    });
  }

  void _resetFilter() {
    setState(() {
      _selectedUpazilla = null;
      _filteredDoctors = _doctors; // Reset to the full list
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
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

              // Dropdown for Upazilla
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal.shade50, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.teal.shade200, width: 1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedUpazilla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'উপজেলা নির্বাচন করুন',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  items:
                      [
                        'ঠাকুরগাঁও সদর',
                        'পীরগঞ্জ',
                        'রাণীশংকৈল',
                        'বালিয়াডাঙ্গী',
                        'হরিপুর',
                      ].map((String upazilla) {
                        return DropdownMenuItem<String>(
                          value: upazilla,
                          child: Text(
                            upazilla,
                            style: TextStyle(color: Colors.teal.shade800),
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUpazilla = value;
                    });
                  },
                  dropdownColor: Colors.teal.shade50,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                ),
              ),
              SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  // Search Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _filterByUpazilla(_selectedUpazilla);
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'খুঁজুন',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 16), // Space between buttons
                  // Reset Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _resetFilter();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.refresh, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'রিসেট করুন',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
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
        title: Text('ডাক্তারগণ'),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchDoctors,
              decoration: InputDecoration(
                labelText: 'ডাক্তার খুঁজুন',
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
              ),
            ),
          ),

          // Doctor List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDoctors.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final doctor = _filteredDoctors[index];
                return DoctorCard(doctor: doctor);
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
}
