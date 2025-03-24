import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';
import '../../utils/app_utils.dart';

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  State<DiagnosticsScreen> createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
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
    final hospitals = await AppUtils.hospitals('diagnostic');
    setState(() {
      _hospitals = hospitals;
      _filteredHospitals = hospitals;
    });
  }

  void _filterHospitals(String query) {
    setState(() {
      _filteredHospitals = _hospitals.where((hospital) {
        final matchesSearch = hospital.name.toLowerCase().contains(query.toLowerCase());
        final matchesUpazilla = _selectedUpazillas.isEmpty || 
            _selectedUpazillas.contains(hospital.upazilla);
        return matchesSearch && matchesUpazilla;
      }).toList();
    });
  }

  void _applyFilters() {
    _filterHospitals(_searchController.text);
  }

  void _showFilterBottomSheet(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context, listen: false).themeMode == ThemeMode.dark;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
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
                  // Header with drag handle
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

                  // Upazilla Checkboxes
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _upazillas.length,
                      itemBuilder: (context, index) {
                        final upazilla = _upazillas[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          elevation: 0,
                          color: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: CheckboxListTile(
                            title: Text(
                              upazilla,
                              style: TextStyle(
                                fontSize: 16,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
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
                            tileColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Apply Filter Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _applyFilters();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'ফিল্টার প্রয়োগ করুন',
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
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('ফোন কল শুরু করা যায়নি'),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ডায়াগনস্টিক সেন্টার',
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
                labelText: 'ডায়াগনস্টিক সেন্টারের নামে খুঁজুন',
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
                          _filterHospitals('');
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

          // Diagnostic Center List
          Expanded(
            child: _filteredHospitals.isEmpty
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
                          'কোন ডায়াগনস্টিক সেন্টার পাওয়া যায়নি',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        if (_selectedUpazillas.isNotEmpty || _searchController.text.isNotEmpty)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedUpazillas.clear();
                                _searchController.clear();
                                _filteredHospitals = _hospitals;
                              });
                            },
                            child: const Text('ফিল্টার সরান'),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredHospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = _filteredHospitals[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 1,
                        color: isDarkMode ? Colors.grey[800] : Colors.white,
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
                              color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              _buildDetailRow(
                                context,
                                Icons.location_on, 
                                hospital.address,
                                isDarkMode: isDarkMode,
                              ),
                              const SizedBox(height: 4),
                              _buildDetailRow(
                                context,
                                Icons.phone, 
                                hospital.contact.join(", "),
                                isDarkMode: isDarkMode,
                              ),
                              const SizedBox(height: 4),
                              _buildDetailRow(
                                context,
                                Icons.email, 
                                hospital.email,
                                isDarkMode: isDarkMode,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'উপজেলা: ${hospital.upazilla}',
                                style: TextStyle(
                                  color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          trailing: GestureDetector(
                            onTap: hospital.contact.isNotEmpty
                                ? () => _makePhoneCall(hospital.contact.first, context)
                                : null,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
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
                        ),
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

  Widget _buildDetailRow(
    BuildContext context,
    IconData icon, 
    String text, {
    required bool isDarkMode,
  }) {
    return Row(
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
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}