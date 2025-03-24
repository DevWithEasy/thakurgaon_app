import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/blood_donar_model.dart';
import '../../utils/app_utils.dart';
import '../../utils/bengali_numerals.dart';

class BloodDonarsScreen extends StatefulWidget {
  const BloodDonarsScreen({super.key});

  @override
  State<BloodDonarsScreen> createState() => _BloodDonarsScreenState();
}

class _BloodDonarsScreenState extends State<BloodDonarsScreen> {
  List<BloodDonor> _donors = [];
  List<BloodDonor> _filteredDonors = [];
  final TextEditingController _searchController = TextEditingController();

  // Variables for modal search criteria
  String _selectedBloodGroup = '';
  String _selectedUpazilla = '';
  final List<String> _upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final donors = await AppUtils.donors();
    setState(() {
      _donors = donors;
      _filteredDonors = donors;
    });
  }

  void _filterDonors() {
    setState(() {
      _filteredDonors = _donors.where((donor) {
        final matchesBloodGroup = _selectedBloodGroup.isEmpty ||
            donor.bloodGroup.toLowerCase() == _selectedBloodGroup.toLowerCase();
        final matchesUpazilla = _selectedUpazilla.isEmpty ||
            donor.upazilla.toLowerCase() == _selectedUpazilla.toLowerCase();
        final matchesSearch = donor.name
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()) ||
            donor.bloodGroup
                .toLowerCase()
                .contains(_searchController.text.toLowerCase());
        return matchesBloodGroup && matchesUpazilla && matchesSearch;
      }).toList();
    });
  }

  void _resetSearch() {
    setState(() {
      _selectedBloodGroup = '';
      _selectedUpazilla = '';
      _searchController.clear();
      _filteredDonors = _donors;
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

  void _openSearchModal(BuildContext context) {
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
                'রক্তদাতা খুঁজুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 16),

              // Blood Group Dropdown
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
                  value: _selectedBloodGroup.isEmpty ? null : _selectedBloodGroup,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'রক্তের গ্রুপ',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'এ+', child: Text('এ+')),
                    DropdownMenuItem(value: 'এ-', child: Text('এ-')),
                    DropdownMenuItem(value: 'বি+', child: Text('বি+')),
                    DropdownMenuItem(value: 'বি-', child: Text('বি-')),
                    DropdownMenuItem(value: 'এবি+', child: Text('এবি+')),
                    DropdownMenuItem(value: 'এবি-', child: Text('এবি-')),
                    DropdownMenuItem(value: 'ও+', child: Text('ও+')),
                    DropdownMenuItem(value: 'ও-', child: Text('ও-')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedBloodGroup = value ?? '';
                    });
                  },
                  dropdownColor: Colors.teal.shade50,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                ),
              ),
              SizedBox(height: 16),

              // Upazilla Dropdown
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
                  value: _selectedUpazilla.isEmpty ? null : _selectedUpazilla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'উপজেলা',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  items: _upazillas.map((upazilla) {
                    return DropdownMenuItem(
                      value: upazilla,
                      child: Text(upazilla),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedUpazilla = value ?? '';
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
                        _filterDonors();
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
                        _resetSearch();
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
        title: Text(
          'রক্তদাতা',
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
              onChanged: (_) => _filterDonors(),
              decoration: InputDecoration(
                hintText: 'নাম বা রক্তের গ্রুপ দিয়ে খুঁজুন...',
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
                          _filterDonors();
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Donor List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredDonors.length,
              itemBuilder: (context, index) {
                final donor = _filteredDonors[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal,
                              child: Text(
                                donor.bloodGroup,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    donor.name,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.teal,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    donor.upazilla,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _makePhoneCall(donor.phone),
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
                                child: Icon(
                                  Icons.call,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        _buildDetailRow(Icons.location_on, donor.address),
                        SizedBox(height: 8),
                        _buildDetailRow(Icons.cake, 'জন্ম তারিখ: ${enToBnNumerals(donor.dob)}'),
                        SizedBox(height: 8),
                        _buildDetailRow(Icons.bloodtype, 'সর্বশেষ রক্তদান: ${enToBnNumerals(donor.lastDonate)} (${donor.daysSinceLastDonation()})'),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'রক্তদানে করতে পারবেন:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                            SizedBox(width: 8),
                            donor.isEligibleToDonate()
                                ? Icon(
                                    Icons.check_circle,
                                    size: 18,
                                    color: Colors.green,
                                  )
                                : Icon(
                                    Icons.cancel_rounded,
                                    size: 18,
                                    color: Colors.red,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openSearchModal(context),
        backgroundColor: Colors.teal,
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.teal),
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