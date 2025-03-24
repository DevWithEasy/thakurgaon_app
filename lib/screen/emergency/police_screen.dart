import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PoliceScreen extends StatefulWidget {
  const PoliceScreen({super.key});

  @override
  _PoliceScreenState createState() => _PoliceScreenState();
}

class _PoliceScreenState extends State<PoliceScreen> {
  List<Map<String, String>> contacts = [
    {
      "id": "1",
      "name": "ঠাকুরগাঁও সদর থানা",
      "officer": "জনাব মোঃ তানভিরুল ইসলাম",
      "phone": "01320-137376",
    },
    {
      "id": "2",
      "name": "বালিয়াডাঙ্গী থানা",
      "officer": "জনাব মোঃ হাবিবুল হক প্রধান",
      "phone": "01320-137402",
    },
    {
      "id": "3",
      "name": "পীরগঞ্জ থানা",
      "officer": "জনাব প্রদীপ কুমার রায়",
      "phone": "01320-137454",
    },
    {
      "id": "4",
      "name": "রাণীশংকৈল থানা",
      "officer": "জনাব এস,এম, জাহিদ ইকবাল",
      "phone": "01320-137428",
    },
    {
      "id": "5",
      "name": "হরিপুর থানা",
      "officer": "জনাব এস,এম, আওরঙ্গজেব",
      "phone": "01320-137480",
    },
    {
      "id": "6",
      "name": "রুহিয়া থানা",
      "officer": "জনাব চিত্ত রঞ্জন রায়",
      "phone": "01320-137506",
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
          .where(
            (contact) => contact['name']!.toLowerCase().contains(
                  query.toLowerCase(),
                ),
          )
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
          'থানা পুলিশ',
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
                hintText: 'থানা পুলিশ খুঁজুন...',
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

          // Police Station List
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
                        // Police Icon
                        Image.asset(
                          'assets/images/home_screen/police.png',
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
                                contact['officer']!,
                                style: TextStyle(fontSize: 14),
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