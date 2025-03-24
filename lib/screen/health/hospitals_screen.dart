import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/model/hospital_model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';
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
                color: isDarkMode ? Colors.grey[800] : Colors.white,
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
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
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
                      color: isDarkMode ? Colors.grey[700] : Colors.teal.shade50,
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

  Future<void> _makePhoneCall(String phoneNumber, BuildContext context) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('ফোন কল শুরু করা যায়নি: $e'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'হাসপাতাল',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode
                  ? [Colors.teal.shade800, Colors.teal.shade900]
                  : [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: _filterHospitals,
                decoration: InputDecoration(
                  labelText: 'হাসপাতালের নামে খুঁজুন',
                  labelStyle: TextStyle(
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                      width: 2,
                    ),
                  ),
                  filled: true,
                  fillColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _filterHospitals('');
                          },
                        )
                      : null,
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),

            // Hospital List
            Expanded(
              child: _filteredHospitals.isEmpty
                  ? Center(
                      child: Text(
                        'কোন হাসপাতাল পাওয়া যায়নি',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredHospitals.length,
                      itemBuilder: (context, index) {
                        final hospital = _filteredHospitals[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: isDarkMode ? 0 : 1,
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
                                SizedBox(height: 4),
                                _buildDetailRow(
                                  Icons.location_on,
                                  hospital.address,
                                  isDarkMode,
                                ),
                                SizedBox(height: 4),
                                _buildDetailRow(
                                  Icons.phone,
                                  hospital.contact.join(", "),
                                  isDarkMode,
                                ),
                                SizedBox(height: 4),
                                _buildDetailRow(
                                  Icons.email,
                                  hospital.email,
                                  isDarkMode,
                                ),
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
                                    colors: isDarkMode
                                        ? [Colors.teal.shade700, Colors.teal.shade800]
                                        : [Colors.teal, Colors.teal.shade700],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
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
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterBottomSheet(context),
        backgroundColor: Colors.teal,
        child: Icon(Icons.filter_list, color: Colors.white),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String text, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
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