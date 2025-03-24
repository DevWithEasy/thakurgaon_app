import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'প্রাইভেসি পলিসি',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            Center(
              child: Image.asset(
                'assets/images/privacy_policy.png',
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Privacy Policy Title
            Text(
              'আমাদের প্রাইভেসি পলিসি',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),

            // Introduction
            Text(
              'আপনার গোপনীয়তা আমাদের কাছে অত্যন্ত গুরুত্বপূর্ণ। এই প্রাইভেসি পলিসি আমাদের অ্যাপ্লিকেশন ব্যবহারের সময় আপনার তথ্য কীভাবে সংগ্রহ, ব্যবহার, এবং সুরক্ষিত করা হয় তা ব্যাখ্যা করে।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 1: Information We Collect
            Text(
              '১. তথ্য সংগ্রহ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা নিম্নলিখিত তথ্য সংগ্রহ করতে পারিঃ\n'
              '- আপনার নাম, ইমেইল, এবং ফোন নম্বর।\n'
              '- আপনার ডিভাইসের তথ্য যেমন মডেল, অপারেটিং সিস্টেম, এবং আইপি ঠিকানা।\n'
              '- অ্যাপ্লিকেশন ব্যবহারের সময় সৃষ্ট লগ ডেটা।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 2: How We Use Your Information
            Text(
              '২. তথ্য ব্যবহার',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা আপনার তথ্য নিম্নলিখিত উদ্দেশ্যে ব্যবহার করিঃ\n'
              '- অ্যাপ্লিকেশন উন্নত করা এবং নতুন বৈশিষ্ট্য যোগ করা।\n'
              '- আপনার অভিজ্ঞতা ব্যক্তিগতকরণ করা।\n'
              '- আপনার সাথে যোগাযোগ করা এবং সেবা সম্পর্কিত তথ্য প্রদান করা।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 3: Data Security
            Text(
              '৩. তথ্য সুরক্ষা',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনার তথ্য সুরক্ষিত রাখতে আমরা নিম্নলিখিত পদক্ষেপ গ্রহণ করিঃ\n'
              '- এনক্রিপশন প্রযুক্তি ব্যবহার করে ডেটা সুরক্ষিত করা।\n'
              '- কঠোর নিরাপত্তা প্রোটোকল অনুসরণ করা।\n'
              '- অননুমোদিত প্রবেশাধিকার প্রতিরোধ করা।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 4: Third-Party Services
            Text(
              '৪. তৃতীয় পক্ষের সেবা',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা তৃতীয় পক্ষের সেবা প্রদানকারীদের সাথে কাজ করতে পারি, যেমনঃ\n'
              '- বিশ্লেষণ সরঞ্জাম (Google Analytics)।\n'
              '- বিজ্ঞাপন নেটওয়ার্ক (Google Ads)।\n'
              '- পেমেন্ট গেটওয়ে (Stripe, PayPal)।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 5: Changes to This Policy
            Text(
              '৫. পলিসি পরিবর্তন',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা এই প্রাইভেসি পলিসি সময়ে সময়ে আপডেট করতে পারি। কোনো পরিবর্তন করা হলে আমরা এই পৃষ্ঠায় তা প্রকাশ করব।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Contact Information
            Text(
              'যোগাযোগ করুন',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনার যদি এই প্রাইভেসি পলিসি সম্পর্কে কোনো প্রশ্ন থাকে, তাহলে আমাদের সাথে যোগাযোগ করুনঃ\n'
              'ইমেইলঃ support@example.com\n'
              'ফোনঃ +880123456789',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}