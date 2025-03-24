import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thakurgaon/utils/app_utils.dart';
import '../components/home_screen_category_grid.dart';
import '../components/home_screen_category_list.dart';
import '../components/home_screen_slider.dart';
import '../model/category_model.dart';
import '../provider/app_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  List<CategoryItem> items = [];

  @override
  void initState() {
    super.initState();
    loadCategories();
  }

  void loadCategories() async {
    final data = await AppUtils.categories();
    setState(() {
      categories = data;
      items = categories.expand((category) => category.items).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDarkMode = provider.themeMode == ThemeMode.dark;
    final bgColor = isDarkMode ? Colors.grey[900]! : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const HomeScreenSlider(), // Slider handles its own dark mode
              const SizedBox(height: 16),
              provider.gridView
                  ? HomeScreenCategoryGrid(
                      items: items,
                    )
                  : HomeScreenCategoryList(
                      categories: categories,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}