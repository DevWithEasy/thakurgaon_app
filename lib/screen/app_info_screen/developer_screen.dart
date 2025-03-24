import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;
    final secondaryTextColor = isDarkMode ? Colors.grey[400]! : Colors.grey[700]!;
    final themeColor = isDarkMode ? Colors.teal[200]! : Colors.teal;
    final chipColor = isDarkMode ? Colors.teal[700]! : Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ডেভেলপার প্রোফাইল',
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
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Developer Profile Image
            CircleAvatar(
              radius: 60,
              backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              backgroundImage: const AssetImage('assets/images/developer.png'),
            ),
            const SizedBox(height: 20),

            // Developer Name
            Text(
              'মোঃ রবিউল আওয়াল',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),

            // Developer Role
            Text(
              'ফুলস্ট্যাক ওয়েব এবং মোবাইল অ্যাপ্লিকেশন ডেভেলপার',
              style: TextStyle(
                fontSize: 18,
                color: secondaryTextColor,
              ),
            ),
            const SizedBox(height: 20),

            // About Developer
            Text(
              'আমি একজন প্যাশনেট ফুলস্ট্যাক ওয়েব এবং মোবাইল অ্যাপ্লিকেশন ডেভেলপার। আমার লক্ষ্য হল ব্যবহারকারীদের জন্য সুন্দর এবং কার্যকরী অ্যাপ্লিকেশন তৈরি করা।',
              style: TextStyle(
                fontSize: 16,
                color: secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Skills Section
            Text(
              'দক্ষতা',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSkillChip('React.js', chipColor),
                _buildSkillChip('Next.js', chipColor),
                _buildSkillChip('Node.js', chipColor),
                _buildSkillChip('MongoDB', chipColor),
                _buildSkillChip('REST API', chipColor),
                _buildSkillChip('ফ্লাটার', chipColor),
                _buildSkillChip('ডার্ট', chipColor),
                _buildSkillChip('ফায়ারবেস', chipColor),
              ],
            ),
            const SizedBox(height: 20),

            // Social Media Links
            Text(
              'আমার সাথে যোগাযোগ করুন',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Facebook
                IconButton(
                  onPressed: () {
                    // Add Facebook link
                  },
                  icon: Image.asset(
                    'assets/images/facebook.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 16),

                // LinkedIn
                IconButton(
                  onPressed: () {
                    // Add LinkedIn link
                  },
                  icon: Image.asset(
                    'assets/images/linkedin.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 16),

                // GitHub
                IconButton(
                  onPressed: () {
                    // Add GitHub link
                  },
                  icon: Image.asset(
                    'assets/images/github.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build skill chips
  Widget _buildSkillChip(String skill, Color chipColor) {
    return Chip(
      label: Text(
        skill,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      backgroundColor: chipColor,
    );
  }
}