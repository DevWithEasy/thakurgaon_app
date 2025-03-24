import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // Demo data for libraries
  final List<Map<String, String>> libraries = [
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

  // Search query
  String searchQuery = '';

  // Filter variables
  String? selectedUpazilla;
  String? selectedType;

  // Applied filters
  String? appliedUpazilla;
  String? appliedType;

  // List of upazillas and types for filtering
  final List<String> upazillas = [
    'ঠাকুরগাঁও সদর',
    'পীরগঞ্জ',
    'রাণীশংকৈল',
    'বালিয়াডাঙ্গী',
    'হরিপুর',
  ];

  final List<String> types = ['পাবলিক', 'সিটি', 'কেন্দ্রীয়'];

  // Function to launch phone dialer
  void _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not make a call to $phoneNumber')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtered libraries based on search query and applied filters
    List<Map<String, String>> filteredLibraries =
        libraries.where((library) {
          final matchesName = library['name']!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
          final matchesUpazilla =
              appliedUpazilla == null || library['upazilla'] == appliedUpazilla;
          final matchesType =
              appliedType == null || library['type'] == appliedType;
          return matchesName && matchesUpazilla && matchesType;
        }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('লাইব্রেরী তালিকা'),
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
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'লাইব্রেরী খুঁজুন',
                prefixIcon: Icon(Icons.search, color: Colors.teal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.teal.shade50,
              ),
            ),
          ),

          // Library List
          Expanded(
            child: ListView.builder(
              itemCount: filteredLibraries.length,
              itemBuilder: (context, index) {
                final library = filteredLibraries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(library['name']!,style: TextStyle(color : Colors.teal)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(library['location']!),
                        Text('যোগাযোগ: ${library['contact']}'),
                        Text('ধরণ: ${library['type']}'),
                      ],
                    ),
                    trailing: GestureDetector(
                              onTap: () => _makePhoneCall(library['contact']!),
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
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openSearchModal(context);
        },
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 1,
        child: const Icon(Icons.filter_list),
      ),
    );
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
              // Header
              Text(
                'লাইব্রেরী ফিল্টার করুন',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 16),

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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: selectedUpazilla,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'উপজেলা',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  items:
                      upazillas.map((upazilla) {
                        return DropdownMenuItem(
                          value: upazilla,
                          child: Text(upazilla),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedUpazilla = value; // Update selected upazilla
                    });
                  },
                  dropdownColor: Colors.teal.shade50,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 16),

              // Type Dropdown
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonFormField<String>(
                  value: selectedType,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'ধরণ',
                    labelStyle: TextStyle(color: Colors.teal),
                  ),
                  items:
                      types.map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedType = value;
                    });
                  },
                  dropdownColor: Colors.teal.shade50,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 20),

              // Buttons
              Row(
                children: [
                  // Filter Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          appliedUpazilla = selectedUpazilla;
                          appliedType = selectedType;
                        });
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
                          Icon(Icons.search, color: Colors.white),
                          const SizedBox(width: 8),
                          Text(
                            'ফিল্টার',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Space between buttons
                  // Reset Button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedUpazilla = null;
                          selectedType = null;
                          appliedUpazilla = null;
                          appliedType = null;
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
