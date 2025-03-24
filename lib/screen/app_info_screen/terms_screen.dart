import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'পরিষেবার শর্তাবলী',
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
                'assets/images/terms_and_conditions.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Terms and Conditions Title
            Text(
              'পরিষেবার শর্তাবলী',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),

            // Introduction
            Text(
              'আমাদের পরিষেবা ব্যবহার করার আগে দয়া করে এই শর্তাবলী ভালোভাবে পড়ুন। আপনি এই পরিষেবা ব্যবহার করার মাধ্যমে এই শর্তাবলী মেনে নিচ্ছেন বলে ধরে নেওয়া হবে।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 1: Acceptance of Terms
            Text(
              '১. শর্তাবলী গ্রহণ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনি আমাদের পরিষেবা ব্যবহার করার মাধ্যমে এই শর্তাবলী এবং আমাদের প্রাইভেসি পলিসি মেনে নিচ্ছেন বলে ধরে নেওয়া হবে। আপনি যদি এই শর্তাবলীর সাথে একমত না হন, তাহলে দয়া করে আমাদের পরিষেবা ব্যবহার করবেন না।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 2: User Responsibilities
            Text(
              '২. ব্যবহারকারীর দায়িত্ব',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আপনি আমাদের পরিষেবা ব্যবহার করার সময় নিম্নলিখিত দায়িত্ব পালন করবেনঃ\n'
              '- কোনো অবৈধ কার্যকলাপে জড়িত হবেন না।\n'
              '- আমাদের পরিষেবার নিরাপত্তা বা কার্যকারিতাকে ক্ষতিগ্রস্ত করবেন না।\n'
              '- অন্য ব্যবহারকারীদের তথ্য বা গোপনীয়তা লঙ্ঘন করবেন না।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 3: Intellectual Property
            Text(
              '৩. বৌদ্ধিক সম্পদ',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমাদের পরিষেবার সমস্ত কন্টেন্ট, লোগো, এবং ডিজাইন আমাদের বৌদ্ধিক সম্পদ। আপনি আমাদের লিখিত অনুমতি ছাড়া এই কন্টেন্ট ব্যবহার, অনুলিপি, বা পরিবর্তন করতে পারবেন না।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 4: Limitation of Liability
            Text(
              '৪. দায় সীমাবদ্ধতা',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা আমাদের পরিষেবার মাধ্যমে সরবরাহকৃত তথ্যের নির্ভুলতা বা সম্পূর্ণতার জন্য কোনো দায় বহন করি না। আপনি আমাদের পরিষেবা ব্যবহারের মাধ্যমে যে কোনো ক্ষতির জন্য আমরা দায়ী থাকব না।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Section 5: Changes to Terms
            Text(
              '৫. শর্তাবলী পরিবর্তন',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'আমরা সময়ে সময়ে এই শর্তাবলী আপডেট করতে পারি। কোনো পরিবর্তন করা হলে আমরা এই পৃষ্ঠায় তা প্রকাশ করব। আপনার পরিষেবা ব্যবহার অব্যাহত রাখার মাধ্যমে আপনি আপডেট করা শর্তাবলী মেনে নিচ্ছেন বলে ধরে নেওয়া হবে।',
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
              'আপনার যদি এই শর্তাবলী সম্পর্কে কোনো প্রশ্ন থাকে, তাহলে আমাদের সাথে যোগাযোগ করুনঃ\n'
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