import 'package:flutter/material.dart';
import '../model/category_model.dart';
import '../provider/app_provider.dart';
import 'package:provider/provider.dart';

class HomeScreenCategoryList extends StatelessWidget {
  final List<Category> categories;
  const HomeScreenCategoryList({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    // Get the current theme mode
    final appProvider = Provider.of<AppProvider>(context);
    final isDarkMode = appProvider.themeMode == ThemeMode.dark;
    
    return ListView.builder(
      itemCount: categories.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Title
              Text(
                category.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold, 
                  fontSize: 16,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 115,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: category.items.length,
                  itemBuilder: (context, itemIndex) {
                    final item = category.items[itemIndex];
                    return GestureDetector(
                      onTap: () {
                        if (item.route.isNotEmpty) {
                          Navigator.pushNamed(context, item.route);
                        }
                      },
                      child: Container(
                        width: 90,
                        padding: EdgeInsets.all(8),
                        margin: const EdgeInsets.only(right: 8.0, bottom: 8),
                        decoration: BoxDecoration(
                          // Use grey color for dark mode, white for light mode
                          color: isDarkMode ? Colors.grey[800] : Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.black12, width: 1),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 1,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(item.image, height: 40, width: 40),
                            Flexible(
                              child: Text(
                                item.title,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  // You might want to adjust text color for dark mode too
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
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}