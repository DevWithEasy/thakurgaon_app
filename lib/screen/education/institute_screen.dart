import 'package:flutter/material.dart';

class InstituteScreen extends StatefulWidget {
  const InstituteScreen({super.key});

  @override
  State<InstituteScreen> createState() => _InstituteScreenState();
}

class _InstituteScreenState extends State<InstituteScreen> {
  final List<Map<String, dynamic>> _list = [
    {
      "title": "হাফেজিয়া মাদ্রাসা",
      "route": "/institute-list",
      "type": "hafeji",
      "image": "assets/images/home_screen/madrasah.png",
    },
    {
      "title": "আলিয়া মাদরাসা",
      "route": "/institute-list",
      "type": "alia",
      "image": "assets/images/home_screen/alia_madrasa.png",
    },
    {
      "title": "কলেজ",
      "route": "/institute-list",
      "type": "collage",
      "image": "assets/images/home_screen/collage.png",
    },
    {
      "title": "কারিগরি শিক্ষা",
      "route": "/institute-list",
      "type": "technical",
      "image": "assets/images/home_screen/technical.png",
    },
    {
      "title": "স্কুল",
      "route": "/institute-list",
      "type": "school",
      "image": "assets/images/home_screen/school.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('শিক্ষা প্রতিষ্ঠান')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemCount: _list.length,
        itemBuilder: (context, index) {
          final item = _list[index];
          return GestureDetector(
            onTap: () {
              if (item['route'].isNotEmpty) {
                Navigator.pushNamed(
                  context,
                  item['route'],
                  arguments: {'type': item['type']},
                );
              }
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    item['image'],
                    height: 40,
                    width: 40,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  Flexible(
                    child: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
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
    );
  }
}
