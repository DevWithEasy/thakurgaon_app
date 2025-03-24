import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import '../../model/news_model.dart';
import '../../provider/app_provider.dart'; // Import your AppProvider

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final News news = ModalRoute.of(context)?.settings.arguments as News;
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.title,
          style: const TextStyle(color: Colors.white),
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
                news.image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
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
              news.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.teal[200] : Colors.teal,
              ),
            ),
            const SizedBox(height: 8),

            // Category and Date
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.teal[900] : Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    news.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDarkMode ? Colors.teal[100] : Colors.teal[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  news.date,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Content
            Text(
              news.content,
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