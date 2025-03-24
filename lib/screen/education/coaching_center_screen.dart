import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../model/coaching_center_model.dart';
import '../../provider/app_provider.dart';
import '../../utils/app_utils.dart';

class CoachingCenterScreen extends StatefulWidget {
  const CoachingCenterScreen({super.key});

  @override
  State<CoachingCenterScreen> createState() => _CoachingCenterScreenState();
}

class _CoachingCenterScreenState extends State<CoachingCenterScreen> {
  List<CoachingCenter> allCenters = [];
  List<CoachingCenter> filteredCenters = [];
  String searchQuery = '';
  String? appliedUpazilla;
  bool isLoading = true;

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

  void _loadData() async {
    try {
      List<CoachingCenter> data = await AppUtils.coachingCenters();
      setState(() {
        allCenters = data;
        filteredCenters = data;
        isLoading = false;
      });
    } catch (error) {
      if (mounted) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $error')),
        );
      }
    }
  }

  void _updateFilteredList() {
    setState(() {
      filteredCenters = allCenters.where((center) {
        final matchesName =
            center.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesUpazilla =
            appliedUpazilla == null || center.upazilla == appliedUpazilla;
        return matchesName && matchesUpazilla;
      }).toList();
    });
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not make a call to $phoneNumber')),
        );
      }
    }
  }

  void _openFilterModal(BuildContext context) {
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
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: upazillas.map((upazilla) {
                  bool isSelected = appliedUpazilla == upazilla;
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        appliedUpazilla = isSelected ? null : upazilla;
                      });
                      Navigator.pop(context);
                      _updateFilteredList();
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0.5,
                      backgroundColor: isSelected 
                          ? Colors.teal 
                          : (isDarkMode ? Colors.grey[800] : Colors.grey.shade50),
                      foregroundColor: isSelected 
                          ? Colors.white 
                          : (isDarkMode ? Colors.white : Colors.teal),
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
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    appliedUpazilla = null;
                  });
                  Navigator.pop(context);
                  _updateFilteredList();
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
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'কোচিং সেন্টার সমুহ',
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
            padding: const EdgeInsets.all(16),
            child: Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    _updateFilteredList();
                  });
                },
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'কোচিং সেন্টার খুঁজুন (নাম,ঠিকানা)',
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.white70 : Colors.black54,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.teal),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.teal),
                          onPressed: () {
                            setState(() {
                              searchQuery = '';
                              _updateFilteredList();
                            });
                          },
                        )
                      : null,
                ),
              ),
            ),
          ),
          
          if (appliedUpazilla != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Chip(
                  label: Text(
                    'উপজেলা: $appliedUpazilla',
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.teal,
                    ),
                  ),
                  backgroundColor: isDarkMode ? Colors.teal[800] : Colors.teal.shade50,
                  deleteIcon: Icon(
                    Icons.close,
                    size: 18,
                    color: isDarkMode ? Colors.white : Colors.teal,
                  ),
                  onDeleted: () {
                    setState(() {
                      appliedUpazilla = null;
                      _updateFilteredList();
                    });
                  },
                ),
              ),
            ),
            
          const SizedBox(height: 8),
          
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredCenters.isEmpty
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
                              'কোন কোচিং সেন্টার পাওয়া যায়নি',
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white70 : Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredCenters.length,
                        itemBuilder: (context, index) {
                          final center = filteredCenters[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[800] : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              title: Text(
                                center.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: isDarkMode 
                                      ? Colors.teal.shade200 
                                      : Colors.teal,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text(
                                    center.location,
                                    style: TextStyle(
                                      color: isDarkMode 
                                          ? Colors.white70 
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'উপজেলা: ${center.upazilla}',
                                    style: TextStyle(
                                      color: isDarkMode 
                                          ? Colors.white70 
                                          : Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.teal,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                onPressed: () => _makePhoneCall(center.contact),
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
          _openFilterModal(context);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}