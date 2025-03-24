import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  _ElectricityScreenState createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  final List<Map<String, String>> contacts =  [
    {"id": "1", "name": "সদর দপ্তর", "phone": "01769-401926"},
    {"id": "2", "name": "পঞ্চগড় জোনাল অফিস", "phone": "01769-401931"},
    {"id": "3", "name": "পীরগঞ্জ জোনাল অফিস", "phone": "01769-401930"},
    {"id": "4", "name": "বোদা সাব জোনাল অফিস", "phone": "01769-401929"},
    {"id": "5", "name": "রাণীশংকৈল জোনাল অফিস", "phone": "01769-401934"},
    {"id": "6", "name": "বালিয়াডাঙ্গী জোনাল অফিস", "phone": "01769-401927"},
    {"id": "7", "name": "গড়েয়া এরিয়া অফিস", "phone": "01769-401928"},
    {"id": "8", "name": "রুহিয়া জোনাল অফিস", "phone": "01769-401932"},
    {"id": "9", "name": "ভুল্লী এরিয়া অফিস", "phone": "01769-401933"},
    {"id": "10", "name": "আটোয়ারী সাব জোনাল অফিস", "phone": "01769-401939"},
    {"id": "11", "name": "বৈরচুনা", "phone": "01769-407570"},
    {"id": "12", "name": "হরিপুর সাব জোনাল অফিস", "phone": "01769-401935"},
    {"id": "13", "name": "নেকমরদ", "phone": "01769-401936"},
    {"id": "14", "name": "দেবীগঞ্জ জোনাল অফিস", "phone": "01769-401937"},
    {"id": "15", "name": "হরিহরপুর", "phone": "01769-401938"},
    {"id": "16", "name": "ভাউলাগঞ্জ", "phone": "01769-401940"},
    {"id": "17", "name": "টেপ্রীগঞ্জ", "phone": "01769-402626"},
    {"id": "18", "name": "লাহিড়ী", "phone": "01769-402269"},
    {"id": "19", "name": "শিবগঞ্জ", "phone": "01769-407435"},
    {"id": "20", "name": "নয়াদিঘী", "phone": "01769-407569"},
    {"id": "21", "name": "দেবনগর", "phone": "01769-407437"},
    {"id": "22", "name": "টুনিরহাট", "phone": "01769-407569"},
    {"id": "23", "name": "ময়দানদিঘী এরিয়া অফিস", "phone": "01769-407046"},
    {"id": "24", "name": "ফুলবাড়ি", "phone": "01714-105924"},
  ];

  List<Map<String, String>> filteredContacts = [];
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredContacts.addAll(contacts);
  }

  void filterContacts(String query) {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('কল করতে ব্যর্থ: $phoneNumber'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
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
          'সকল বিদ্যুৎ অফিস',
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
                controller: searchController,
                onChanged: filterContacts,
                decoration: InputDecoration(
                  hintText: 'বিদ্যুৎ অফিস খুঁজুন...',
                  hintStyle: TextStyle(
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
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                          ),
                          onPressed: () {
                            searchController.clear();
                            filterContacts('');
                          },
                        )
                      : null,
                ),
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),

            // Electricity Office List
            Expanded(
              child: filteredContacts.isEmpty
                  ? Center(
                      child: Text(
                        'কোন বিদ্যুৎ অফিস পাওয়া যায়নি',
                        style: TextStyle(
                          fontSize: 18,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = filteredContacts[index];
                        return Card(
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          elevation: isDarkMode ? 0 : 1,
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Row(
                              children: [
                                // Electricity Icon
                                Image.asset(
                                  'assets/images/home_screen/electric_service.png',
                                  width: 40,
                                ),
                                SizedBox(width: 16),

                                // Contact Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact['name']!,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isDarkMode
                                              ? Colors.teal.shade200
                                              : Colors.teal,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        contact['phone']!,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: isDarkMode
                                              ? Colors.grey[300]
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Call Button
                                GestureDetector(
                                  onTap: () => _makePhoneCall(contact['phone']!),
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}