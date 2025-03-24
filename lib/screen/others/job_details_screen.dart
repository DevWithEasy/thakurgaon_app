import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/job_model.dart';
import '../../provider/app_provider.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Job job = ModalRoute.of(context)?.settings.arguments as Job;
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'চাকরি বিস্তারিত',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                job.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.business_center,
                        size: 50,
                        color: isDarkMode ? Colors.grey[500] : Colors.grey[600],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              job.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.teal[200] : Colors.teal,
              ),
            ),
            const SizedBox(height: 8),

            // Company and Category
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.teal[900] : Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.company,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.teal[100] : Colors.teal[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.teal[900] : Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    job.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.teal[100] : Colors.teal[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Location and Deadline
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.location_on, 
                      size: 16, 
                      color: isDarkMode ? Colors.teal[200] : Colors.teal,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      job.location,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Text(
                  'ডেডলাইন: ${job.deadline}',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Salary
            Row(
              children: [
                Icon(
                  Icons.attach_money, 
                  size: 16, 
                  color: isDarkMode ? Colors.teal[200] : Colors.teal,
                ),
                const SizedBox(width: 4),
                Text(
                  job.salary,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.teal[200] : Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              job.description,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}