import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class FireServiceScreen extends StatefulWidget {
  const FireServiceScreen({super.key});

  @override
  _FireServiceScreenState createState() => _FireServiceScreenState();
}

class _FireServiceScreenState extends State<FireServiceScreen> {
  final List<Map<String, String>> contacts = [
    {
      "id": "1",
      "name": "উপসহকারী পরিচালক, ঠাকুরগাঁও",
      "phone": "01901023208",
    },
    {
      "id": "2",
      "name": "ঠাকুরগাঁও ফায়ার স্টেশন",
      "phone": "01901023285",
    },
    {
      "id": "3",
      "name": "পীরগঞ্জ ফায়ার স্টেশন",
      "phone": "01901023291",
    },
    {
      "id": "4",
      "name": "বালিয়াডাঙ্গী ফায়ার স্টেশন",
      "phone": "01901023287",
    },
    {
      "id": "5",
      "name": "রানীশংকৈল ফায়ার স্টেশন",
      "phone": "01901023295",
    },
    {
      "id": "6",
      "name": "হরিপুর ফায়ার স্টেশন",
      "phone": "01901023289",
    },
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
          'ফায়ার সার্ভিস',
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
                  hintText: 'ফায়ার সার্ভিস খুঁজুন...',
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

            // Fire Service List
            Expanded(
              child: filteredContacts.isEmpty
                  ? Center(
                      child: Text(
                        'কোন ফায়ার স্টেশন পাওয়া যায়নি',
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
                                // Fire Service Icon
                                Image.asset(
                                  'assets/images/home_screen/fire_service.png',
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