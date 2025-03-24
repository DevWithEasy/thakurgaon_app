import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FireServiceScreen extends StatefulWidget {
  const FireServiceScreen({super.key});

  @override
  _FireServiceScreenState createState() => _FireServiceScreenState();
}

class _FireServiceScreenState extends State<FireServiceScreen> {
  List<Map<String, String>> contacts = [
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
  TextEditingController searchController = TextEditingController();

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

  _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      await launchUrl(launchUri);
    } catch (e) {
      print('Could not launch $launchUri: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ফায়ার সার্ভিস',
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
              controller: searchController,
              onChanged: filterContacts,
              decoration: InputDecoration(
                hintText: 'ফায়ার সার্ভিস খুঁজুন...',
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
                fillColor: Colors.teal.shade50,
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.teal),
                        onPressed: () {
                          searchController.clear();
                          filterContacts('');
                        },
                      )
                    : null,
              ),
            ),
          ),

          // Fire Service List
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = filteredContacts[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  elevation: 1,
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
                                  color: Colors.teal,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                contact['phone']!,
                                style: TextStyle(fontSize: 14),
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}