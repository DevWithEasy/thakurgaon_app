import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../provider/app_provider.dart';

class HelplineScreen extends StatefulWidget {
  const HelplineScreen({super.key});

  @override
  _HelplineScreenState createState() => _HelplineScreenState();
}

class _HelplineScreenState extends State<HelplineScreen> {
  final List<Map<String, String>> contacts = [
    {"name": "জরুরি সেবা (পুলিশ, ফায়ার সার্ভিস, অ্যাম্বুলেন্স)", "phone": "999"},
    {"name": "শিশু সহায়তা", "phone": "1098"},
    {"name": "নারী ও শিশু নির্যাতন প্রতিরোধ", "phone": "109"},
    {"name": "জাতীয় পরিচয়পত্র তথ্য", "phone": "105"},
    {"name": "সরকারি আইনি সহায়তা", "phone": "16430"},
    {"name": "দুর্যোগের আগাম বার্তা", "phone": "10941"},
    {"name": "দুর্নীতি দমন কমিশন (দুদক) হটলাইন", "phone": "106"},
    {"name": "জাতীয় তথ্য বাতায়ন", "phone": "333"},
    {"name": "স্বাস্থ্য বাতায়ন", "phone": "16263"},
    {"name": "কৃষি বিষয়ক পরামর্শ", "phone": "16123"},
    {"name": "রেলওয়ে কল সেন্টার", "phone": "131"},
    {"name": "বিটিআরসি কল সেন্টার", "phone": "100"},
    {"name": "বিটিসিএল কল সেন্টার", "phone": "16420"},
    {"name": "মানবাধিকার সহায়তা কল সেন্টার", "phone": "16108"},
    {"name": "বাংলাদেশ ব্যাংকের গ্রাহক অভিযোগ হটলাইন", "phone": "16236"},
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
          'জাতীয় জরুরি সেবা',
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
                  hintText: 'সার্চ করুন...',
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

            // Helpline List
            Expanded(
              child: filteredContacts.isEmpty
                  ? Center(
                      child: Text(
                        'কোন হেল্পলাইন পাওয়া যায়নি',
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
                                // Helpline Icon
                                Image.asset(
                                  'assets/images/home_screen/helpline.png',
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