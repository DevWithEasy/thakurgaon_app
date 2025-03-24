import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../provider/app_provider.dart'; // Import your provider
import 'package:provider/provider.dart'; // Import provider package

class HomeScreenCategoryGrid extends StatelessWidget {
  final List<CategoryItem> items;
  const HomeScreenCategoryGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final appProvider = Provider.of<AppProvider>(context);
    final isDarkMode = appProvider.themeMode == ThemeMode.dark;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
          onTap: () {
            if (item.route.isNotEmpty) {
              Navigator.pushNamed(context, item.route);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // Use grey color for dark mode, white for light mode
              color: isDarkMode ? Colors.grey[800] : Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  item.image,
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 20),
                Flexible(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      // Adjust text color for dark mode
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}