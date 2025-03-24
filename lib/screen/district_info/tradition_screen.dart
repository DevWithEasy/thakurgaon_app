import 'package:flutter/material.dart';
import '../../model/Info_model.dart';

class TraditionScreen extends StatefulWidget {
  const TraditionScreen({super.key});

  @override
  State<TraditionScreen> createState() => _TraditionScreenState();
}

class _TraditionScreenState extends State<TraditionScreen> {
  late int _currentIndex;
  late List<Info> _traditions;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    _currentIndex = args['index'];
    _traditions = args['traditions'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _traditions[_currentIndex].title,
          style: TextStyle(
            fontSize: 20,
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
      ),
      body: PageView.builder(
        itemCount: _traditions.length,
        controller: PageController(initialPage: _currentIndex),
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final tradition = _traditions[index];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Image (if available)
                // if (tradition.image != null)
                //   ClipRRect(
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(20),
                //       bottomRight: Radius.circular(20),
                //     ),
                //     child: Image.asset(
                //       tradition.image!,
                //       width: double.infinity,
                //       height: 300,
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                const SizedBox(height: 20),

                // Tradition Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    tradition.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Tradition Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    tradition.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                      fontFamily: 'kalpurush',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}