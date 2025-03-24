import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;
    final tileColor = isDarkMode ? Colors.grey[800]! : Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'কৃতজ্ঞতা',
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Thank You Image
            Image.asset(
              'assets/images/thank_you.png',
              height: 150,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            // Thank You Message
            Text(
              'আপনাকে ধন্যবাদ!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনার সমর্থন এবং আস্থার জন্য আমরা কৃতজ্ঞ। আমাদের অ্যাপ্লিকেশন ব্যবহার করার জন্য আপনাকে আন্তরিক ধন্যবাদ।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Acknowledgments Title
            Text(
              'কৃতজ্ঞতা স্বীকার',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),

            // Acknowledgments List
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: tileColor,
                  child: ListTile(
                    leading: Icon(Icons.people, color: themeColor),
                    title: Text(
                      'আমাদের ব্যবহারকারীগণ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    subtitle: Text(
                      'আমাদের অ্যাপ্লিকেশন ব্যবহার করে এবং মূল্যবান প্রতিক্রিয়া প্রদানের জন্য ধন্যবাদ।',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: tileColor,
                  child: ListTile(
                    leading: Icon(Icons.code, color: themeColor),
                    title: Text(
                      'ডেভেলপার দল',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    subtitle: Text(
                      'এই অ্যাপ্লিকেশনটি তৈরি করতে অক্লান্ত পরিশ্রম করার জন্য আমাদের ডেভেলপার দলকে ধন্যবাদ।',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: tileColor,
                  child: ListTile(
                    leading: Icon(Icons.thumb_up, color: themeColor),
                    title: Text(
                      'সমর্থকগণ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                      ),
                    ),
                    subtitle: Text(
                      'আমাদের অ্যাপ্লিকেশনকে এগিয়ে নেওয়ার জন্য সমর্থন এবং উৎসাহ প্রদানের জন্য ধন্যবাদ।',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryTextColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Back to Home Button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'হোম স্ক্রিনে ফিরুন',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}