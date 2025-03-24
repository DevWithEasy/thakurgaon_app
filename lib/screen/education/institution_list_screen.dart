import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/institute_model.dart';
import 'package:thakurgaon/utils/app_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../provider/app_provider.dart';

class InstituteListScreen extends StatefulWidget {
  const InstituteListScreen({super.key});

  @override
  State<InstituteListScreen> createState() => _InstituteListScreenState();
}

class _InstituteListScreenState extends State<InstituteListScreen> {
  List<Institute> _institutes = [];
  String _searchQuery = '';
  String? _appliedUpazilla;
  bool _isLoading = true;

  final List<String> _upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      final type = args?['type'];
      
      setState(() => _isLoading = true);
      
      final data = await AppUtils.institutions(type);
      setState(() {
        _institutes = data;
        _isLoading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('ডেটা লোড করতে ব্যর্থ: $error')),
        );
      }
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('কল করতে ব্যর্থ হয়েছে')),
        );
      }
    }
  }

  List<Institute> get _filteredInstitutes {
    return _institutes.where((institute) {
      final matchesSearch = institute.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesUpazilla = _appliedUpazilla == null || 
          institute.upazilla == _appliedUpazilla;
      return matchesSearch && matchesUpazilla;
    }).toList();
  }

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _appliedUpazilla = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'শিক্ষা প্রতিষ্ঠান তালিকা',
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
          // Search and Filter Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    labelText: 'খুঁজুন...',
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
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: Icon(Icons.clear, color: Colors.teal),
                            onPressed: () => setState(() => _searchQuery = ''),
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
                if (_appliedUpazilla != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        Chip(
                          label: Text(
                            'উপজেলা: $_appliedUpazilla',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.teal,
                            ),
                          ),
                          backgroundColor: isDarkMode ? Colors.teal[800] : Colors.teal.shade100,
                          deleteIcon: Icon(
                            Icons.close,
                            size: 18,
                            color: isDarkMode ? Colors.white : Colors.teal,
                          ),
                          onDeleted: () => setState(() => _appliedUpazilla = null),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // Institute List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _filteredInstitutes.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.school,
                              size: 60,
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'কোন প্রতিষ্ঠান পাওয়া যায়নি',
                              style: TextStyle(
                                fontSize: 18,
                                color: isDarkMode ? Colors.white70 : Colors.black54,
                              ),
                            ),
                            if (_searchQuery.isNotEmpty || _appliedUpazilla != null)
                              TextButton(
                                onPressed: _resetFilters,
                                child: const Text('ফিল্টার সরান'),
                              ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _filteredInstitutes.length,
                        itemBuilder: (context, index) {
                          final institute = _filteredInstitutes[index];
                          return _buildInstituteCard(institute, isDarkMode);
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context, isDarkMode),
        backgroundColor: Colors.teal,
        child: const Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildInstituteCard(Institute institute, bool isDarkMode) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {}, // Add navigation if needed
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name and Call Button
              Row(
                children: [
                  Expanded(
                    child: Text(
                      institute.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                      ),
                    ),
                  ),
                  if (institute.contact.isNotEmpty)
                    GestureDetector(
                      onTap: () => _makePhoneCall(institute.contact),
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
              const SizedBox(height: 12),
              // Location
              _buildDetailRow(
                Icons.location_on,
                institute.location,
                isDarkMode,
              ),
              // Contact
              if (institute.contact.isNotEmpty)
                _buildDetailRow(
                  Icons.phone,
                  institute.contact,
                  isDarkMode,
                ),
              // Email
              if (institute.email.isNotEmpty)
                _buildDetailRow(
                  Icons.email,
                  institute.email,
                  isDarkMode,
                ),
              // Upazilla
              _buildDetailRow(
                Icons.map,
                'উপজেলা: ${institute.upazilla}',
                isDarkMode,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context, bool isDarkMode) {
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
              // Drag Handle
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
              // Title
              Text(
                'ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                ),
              ),
              const SizedBox(height: 16),
              // Upazilla Buttons
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _upazillas.map((upazilla) {
                  final isSelected = _appliedUpazilla == upazilla;
                  return FilterChip(
                    label: Text(
                      upazilla,
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : (isDarkMode ? Colors.white : Colors.teal),
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _appliedUpazilla = selected ? upazilla : null;
                      });
                      Navigator.pop(context);
                    },
                    backgroundColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                    selectedColor: Colors.teal,
                    checkmarkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              // Reset Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() => _appliedUpazilla = null);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'ফিল্টার সরান',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
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