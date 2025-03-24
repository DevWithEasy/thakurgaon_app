import 'package:flutter/material.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Thank You Image
            Image.asset(
              'assets/images/thank_you.png', // Add your image asset here
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Thank You Message
            const Text(
              'আপনাকে ধন্যবাদ!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'আপনার সমর্থন এবং আস্থার জন্য আমরা কৃতজ্ঞ। আমাদের অ্যাপ্লিকেশন ব্যবহার করার জন্য আপনাকে আন্তরিক ধন্যবাদ।',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Acknowledgments Title
            const Text(
              'কৃতজ্ঞতা স্বীকার',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            // Acknowledgments List
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Icon(Icons.people, color: Colors.teal),
                  title: Text(
                    'আমাদের ব্যবহারকারীগণ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    'আমাদের অ্যাপ্লিকেশন ব্যবহার করে এবং মূল্যবান প্রতিক্রিয়া প্রদানের জন্য ধন্যবাদ।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.code, color: Colors.teal),
                  title: Text(
                    'ডেভেলপার দল',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    'এই অ্যাপ্লিকেশনটি তৈরি করতে অক্লান্ত পরিশ্রম করার জন্য আমাদের ডেভেলপার দলকে ধন্যবাদ।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.thumb_up, color: Colors.teal),
                  title: Text(
                    'সমর্থকগণ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  subtitle: Text(
                    'আমাদের অ্যাপ্লিকেশনকে এগিয়ে নেওয়ার জন্য সমর্থন এবং উৎসাহ প্রদানের জন্য ধন্যবাদ।',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Back to Home Button
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home screen
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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