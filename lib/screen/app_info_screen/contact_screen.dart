import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/app_provider.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final cardColor = isDarkMode ? Colors.grey[800]! : Colors.white;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'যোগাযোগ করুন',
          style: TextStyle(
            fontSize: 22,
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header Image
            Image.asset(
              'assets/images/contact_me.png',
              height: 70,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Contact Form
            Text(
              'যোগাযোগ ফর্ম',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমাদের সাথে যোগাযোগ করতে নিচের ফর্মটি পূরণ করুন।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Name Field
            TextFormField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'আপনার নাম',
                labelStyle: TextStyle(color: secondaryTextColor),
                prefixIcon: Icon(Icons.person, color: themeColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryTextColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryTextColor),
                ),
                filled: true,
                fillColor: cardColor,
              ),
            ),
            const SizedBox(height: 16),

            // Email Field
            TextFormField(
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: 'ইমেইল',
                labelStyle: TextStyle(color: secondaryTextColor),
                prefixIcon: Icon(Icons.email, color: themeColor),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryTextColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: secondaryTextColor),
                ),
                filled: true,
                fillColor: cardColor,
              ),
            ),
            const SizedBox(height: 16),

            // Message Field
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.message, color: themeColor),
                      const SizedBox(width: 8),
                      Text(
                        'বার্তা',
                        style: TextStyle(
                          fontSize: 16,
                          color: themeColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  style: TextStyle(color: textColor),
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: secondaryTextColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: secondaryTextColor),
                    ),
                    filled: true,
                    fillColor: cardColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              children: [
                // Call Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement call functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text(
                      'কল করুন',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Message Button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Implement message functionality
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    icon: const Icon(Icons.message, color: Colors.white),
                    label: const Text(
                      'মেসেজ করুন',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}