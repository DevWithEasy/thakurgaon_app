import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/uddokta_model.dart';
import '../../utils/app_utils.dart';
import '../../provider/app_provider.dart';

class UddoktaScreen extends StatefulWidget {
  const UddoktaScreen({super.key});

  @override
  State<UddoktaScreen> createState() => _UddoktaScreenState();
}

class _UddoktaScreenState extends State<UddoktaScreen> {
  List<Uddokta> allUddoktas = [];
  List<Uddokta> filteredUddoktas = [];
  String searchQuery = '';
  String? appliedUpazilla;

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
      List<Uddokta> data = await AppUtils.loadUddoktas();
      setState(() {
        allUddoktas = data;
        filteredUddoktas = data;
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load data: $error')),
        );
      }
    }
  }

  void _updateFilteredList() {
    setState(() {
      filteredUddoktas = allUddoktas.where((uddokta) {
        final matchesName = 
            uddokta.name.toLowerCase().contains(searchQuery.toLowerCase());
        final matchesUpazilla = 
            appliedUpazilla == null || uddokta.upazilla == appliedUpazilla;
        return matchesName && matchesUpazilla;
      }).toList();
    });
  }

  void _openFilterModal(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey[800] : Colors.white,
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
              Text(
                'ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
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
                          : (isDarkMode ? Colors.grey[700] : Colors.grey.shade50),
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
    final themeMode = Provider.of<AppProvider>(context).themeMode;
    final isDarkMode = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('উদ্যোক্তা'),
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  _updateFilteredList();
                });
              },
              decoration: InputDecoration(
                labelText: 'উদ্যোক্তা খুঁজুন',
                prefixIcon: const Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                labelStyle: TextStyle(
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: filteredUddoktas.length,
              itemBuilder: (context, index) {
                final uddokta = filteredUddoktas[index];
                return Card(
                  elevation: 1,
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isDarkMode ? Colors.grey[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/uddokta-details',
                        arguments: {'id': uddokta.id},
                      );
                    },
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.network(
                            uddokta.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                uddokta.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                uddokta.business,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                uddokta.location,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDarkMode ? Colors.grey[300] : Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
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
        onPressed: () => _openFilterModal(context),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
        child: const Icon(Icons.filter_list),
      ),
    );
  }
}