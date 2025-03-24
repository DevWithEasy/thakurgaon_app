import 'package:flutter/material.dart';

class DeveloperScreen extends StatelessWidget {
  const DeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Developer Profile Image
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/developer.png'),
            ),
            const SizedBox(height: 20),

            // Developer Name
            const Text(
              'মোঃ রবিউল আওয়াল',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),

            // Developer Role
            const Text(
              'ফুলস্ট্যাক ওয়েব এবং মোবাইল অ্যাপ্লিকেশন ডেভেলপার',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // About Developer
            const Text(
              'আমি একজন প্যাশনেট ফুলস্ট্যাক ওয়েব এবং মোবাইল অ্যাপ্লিকেশন ডেভেলপার। আমার লক্ষ্য হল ব্যবহারকারীদের জন্য সুন্দর এবং কার্যকরী অ্যাপ্লিকেশন তৈরি করা।',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Skills Section
            const Text(
              'দক্ষতা',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildSkillChip('React.js'),
                _buildSkillChip('Next.js'),
                _buildSkillChip('Node.js'),
                _buildSkillChip('MongoDB'),
                _buildSkillChip('REST API'),
                _buildSkillChip('ফ্লাটার'),
                _buildSkillChip('ডার্ট'),
                _buildSkillChip('ফায়ারবেস'),
              ],
            ),
            const SizedBox(height: 20),

            // Social Media Links
            const Text(
              'আমার সাথে যোগাযোগ করুন',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
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
  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(
        skill,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.teal,
    );
  }
}