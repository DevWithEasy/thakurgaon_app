import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<Map<String, String>> _libraries = [
    {
      'name': 'ঢাকা পাবলিক লাইব্রেরী',
      'location': 'ঢাকা, বাংলাদেশ',
      'contact': '01712345678',
      'type': 'পাবলিক',
      'upazilla': 'ঠাকুরগাঁও সদর',
    },
    {
      'name': 'চট্টগ্রাম সিটি লাইব্রেরী',
      'location': 'চট্টগ্রাম, বাংলাদেশ',
      'contact': '01898765432',
      'type': 'সিটি',
      'upazilla': 'পীরগঞ্জ',
    },
    {
      'name': 'রাজশাহী কেন্দ্রীয় লাইব্রেরী',
      'location': 'রাজশাহী, বাংলাদেশ',
      'contact': '01911223344',
      'type': 'কেন্দ্রীয়',
      'upazilla': 'রাণীশংকৈল',
    },
    {
      'name': 'খুলনা পাবলিক লাইব্রেরী',
      'location': 'খুলনা, বাংলাদেশ',
      'contact': '01655667788',
      'type': 'পাবলিক',
      'upazilla': 'বালিয়াডাঙ্গী',
    },
    {
      'name': 'সিলেট সিটি লাইব্রেরী',
      'location': 'সিলেট, বাংলাদেশ',
      'contact': '01512345678',
      'type': 'সিটি',
      'upazilla': 'হরিপুর',
    },
  ];

  String _searchQuery = '';
  String? _selectedUpazilla;
  String? _selectedType;
  final List<String> _upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];
  final List<String> _types = ['পাবলিক', 'সিটি', 'কেন্দ্রীয়'];

  List<Map<String, String>> get _filteredLibraries {
    return _libraries.where((library) {
      final matchesName = library['name']!.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      final matchesUpazilla = _selectedUpazilla == null || 
          library['upazilla'] == _selectedUpazilla;
      final matchesType = _selectedType == null || 
          library['type'] == _selectedType;
      return matchesName && matchesUpazilla && matchesType;
    }).toList();
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

  void _resetFilters() {
    setState(() {
      _searchQuery = '';
      _selectedUpazilla = null;
      _selectedType = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'লাইব্রেরী তালিকা',
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
            child: Column(
              children: [
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    labelText: 'লাইব্রেরী খুঁজুন',
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
                if (_selectedUpazilla != null || _selectedType != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      children: [
                        if (_selectedUpazilla != null)
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Chip(
                              label: Text(
                                'উপজেলা: $_selectedUpazilla',
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
                              onDeleted: () => setState(() => _selectedUpazilla = null),
                            ),
                          ),
                        if (_selectedType != null)
                          Chip(
                            label: Text(
                              'ধরণ: $_selectedType',
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
                            onDeleted: () => setState(() => _selectedType = null),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: _filteredLibraries.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.library_books,
                          size: 60,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'কোন লাইব্রেরী পাওয়া যায়নি',
                          style: TextStyle(
                            fontSize: 18,
                            color: isDarkMode ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        if (_searchQuery.isNotEmpty || _selectedUpazilla != null || _selectedType != null)
                          TextButton(
                            onPressed: _resetFilters,
                            child: const Text('ফিল্টার সরান'),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredLibraries.length,
                    itemBuilder: (context, index) {
                      final library = _filteredLibraries[index];
                      return _buildLibraryCard(library, isDarkMode);
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

  Widget _buildLibraryCard(Map<String, String> library, bool isDarkMode) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 1,
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    library['name']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _makePhoneCall(library['contact']!),
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
            _buildDetailRow(Icons.location_on, library['location']!, isDarkMode),
            _buildDetailRow(Icons.category, 'ধরণ: ${library['type']}', isDarkMode),
            _buildDetailRow(Icons.map, 'উপজেলা: ${library['upazilla']}', isDarkMode),
            if (library['contact']!.isNotEmpty)
              _buildDetailRow(Icons.phone, 'যোগাযোগ: ${library['contact']}', isDarkMode),
          ],
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
                  items: _upazillas.map((upazilla) {
                    return DropdownMenuItem<String>(
                      value: upazilla,
                      child: Text(
                        upazilla,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedUpazilla = value),
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
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
                  value: _selectedType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'ধরণ নির্বাচন করুন',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    ),
                  ),
                  items: _types.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedType = value),
                  dropdownColor: isDarkMode ? Colors.grey[800] : Colors.teal.shade50,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'ফিল্টার প্রয়োগ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedUpazilla = null;
                          _selectedType = null;
                        });
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'রিসেট করুন',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
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
}