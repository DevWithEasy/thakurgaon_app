import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/doctor_card.dart';
import '../../model/doctor_model.dart';
import '../../provider/app_provider.dart';
import '../../utils/app_utils.dart';

class DoctorsScreen extends StatefulWidget {
  const DoctorsScreen({super.key});

  @override
  State<DoctorsScreen> createState() => _DoctorsScreenState();
}

class _DoctorsScreenState extends State<DoctorsScreen> {
  List<Doctor> _doctors = [];
  List<Doctor> _filteredDoctors = [];
  String? _selectedUpazilla;
  final TextEditingController _searchController = TextEditingController();

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
      _filteredDoctors = _doctors.where((doctor) {
        final nameMatch = doctor.name.toLowerCase().contains(query.toLowerCase());
        final specializationMatch = doctor.specialization.any(
          (specialization) => specialization.toLowerCase().contains(query.toLowerCase()),
        );
        final qualificationMatch = doctor.qualifications.any(
          (qualification) => qualification.toLowerCase().contains(query.toLowerCase()),
        );
        final upazillaMatch = _selectedUpazilla == null || 
            doctor.upazilla == _selectedUpazilla;
        return (nameMatch || specializationMatch || qualificationMatch) && upazillaMatch;
      }).toList();
    });
  }

  void _filterByUpazilla(String? upazilla) {
    setState(() {
      _selectedUpazilla = upazilla;
      _searchDoctors(_searchController.text);
    });
  }

  void _resetFilter() {
    setState(() {
      _selectedUpazilla = null;
      _searchController.clear();
      _filteredDoctors = _doctors;
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context, listen: false).themeMode == ThemeMode.dark;
    final upazillas = [
      'ঠাকুরগাঁও সদর',
      'পীরগঞ্জ',
      'রাণীশংকৈল',
      'বালিয়াডাঙ্গী',
      'হরিপুর',
    ];

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
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDarkMode
                      ? [Colors.grey[800]!, Colors.grey[700]!]
                      : [Colors.teal.shade50, Colors.blue.shade50],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: isDarkMode ? Colors.teal.shade400 : Colors.teal.shade200,
                    width: 1,
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: _selectedUpazilla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'উপজেলা নির্বাচন করুন',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    ),
                  ),
                  items: upazillas.map((upazilla) {
                    return DropdownMenuItem<String>(
                      value: upazilla,
                      child: Text(
                        upazilla,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.teal.shade800,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: _filterByUpazilla,
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
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
                          Text(
                            'ফিল্টার প্রয়োগ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.refresh, color: Colors.white),
                          const SizedBox(width: 8),
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
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ডাক্তারগণ',
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
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
                fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.teal),
                        onPressed: () {
                          _searchController.clear();
                          _searchDoctors('');
                        },
                      )
                    : null,
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          if (_selectedUpazilla != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Chip(
                    label: Text(
                      'উপজেলা: $_selectedUpazilla',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.teal,
                      ),
                    ),
                    backgroundColor: isDarkMode ? Colors.teal.shade800 : Colors.teal.shade100,
                    deleteIcon: Icon(
                      Icons.close,
                      size: 18,
                      color: isDarkMode ? Colors.white : Colors.teal,
                    ),
                    onDeleted: () => _filterByUpazilla(null),
                  ),
                ],
              ),
            ),
          Expanded(
            child: _filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.medical_services,
                          size: 60,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'কোন ডাক্তার পাওয়া যায়নি',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        if (_selectedUpazilla != null || _searchController.text.isNotEmpty)
                          TextButton(
                            onPressed: _resetFilter,
                            child: const Text('ফিল্টার সরান'),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredDoctors.length,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final doctor = _filteredDoctors[index];
                      return DoctorCard(
                        doctor: doctor,
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}