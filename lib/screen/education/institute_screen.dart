import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/app_provider.dart';

class InstituteScreen extends StatefulWidget {
  const InstituteScreen({super.key});

  @override
  State<InstituteScreen> createState() => _InstituteScreenState();
}

class _InstituteScreenState extends State<InstituteScreen> {
  final List<Map<String, dynamic>> _institutes = [
    {
      "title": "হাফেজিয়া মাদ্রাসা",
      "route": "/institute-list",
      "type": "hafeji",
      "image": "assets/images/home_screen/madrasah.png",
      "color": Colors.teal,
    },
    {
      "title": "আলিয়া মাদরাসা",
      "route": "/institute-list",
      "type": "alia",
      "image": "assets/images/home_screen/alia_madrasa.png",
      "color": Colors.blue,
    },
    {
      "title": "কলেজ",
      "route": "/institute-list",
      "type": "collage",
      "image": "assets/images/home_screen/collage.png",
      "color": Colors.orange,
    },
    {
      "title": "কারিগরি শিক্ষা",
      "route": "/institute-list",
      "type": "technical",
      "image": "assets/images/home_screen/technical.png",
      "color": Colors.purple,
    },
    {
      "title": "স্কুল",
      "route": "/institute-list",
      "type": "school",
      "image": "assets/images/home_screen/school.png",
      "color": Colors.green,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'শিক্ষা প্রতিষ্ঠান',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          itemCount: _institutes.length,
          itemBuilder: (context, index) {
            final institute = _institutes[index];
            return _buildInstituteCard(context, institute, isDarkMode);
          },
        ),
      ),
    );
  }

  Widget _buildInstituteCard(
      BuildContext context, Map<String, dynamic> institute, bool isDarkMode) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isDarkMode ? Colors.grey[800] : Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (institute['route'].isNotEmpty) {
            Navigator.pushNamed(
              context,
              institute['route'],
              arguments: {'type': institute['type']},
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: (institute['color'] as Color).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Image.asset(
                    institute['image'],
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: Text(
                  institute['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}