import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/Info_model.dart';
import '../../provider/app_provider.dart';
import '../../utils/app_utils.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  List<Info> _infos = [];
  Map<int, bool> _expandedStates = {};

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final infos = await AppUtils.infos();
    setState(() {
      _infos = infos;
      // Set the first item as initially expanded
      _expandedStates = {for (var i = 0; i < infos.length; i++) i: i == 0};
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<AppProvider>(context).themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'এক নজরে ঠাকুরগাঁও',
          style: TextStyle(
            fontFamily: 'kalpurush',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDarkMode 
                  ? [Colors.teal.shade800, Colors.teal.shade900]
                  : [Colors.teal, Colors.teal.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        child: ListView.builder(
          itemCount: _infos.length,
          padding: const EdgeInsets.all(16),
          itemBuilder: (context, index) {
            final info = _infos[index];
            final isExpanded = _expandedStates[index] ?? false;

            return Card(
              elevation: isDarkMode ? 0 : 0.5,
              margin: EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: isDarkMode ? Colors.grey[800] : null,
              child: Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  cardColor: isDarkMode ? Colors.grey[800] : Colors.white,
                ),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    gradient: isExpanded
                        ? isDarkMode
                            ? LinearGradient(
                                colors: [Colors.teal.shade900, Colors.teal.shade800],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : LinearGradient(
                                colors: [Colors.teal.shade100, Colors.teal.shade50],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                        : null,
                    borderRadius: BorderRadius.circular(12),
                    color: isDarkMode ? Colors.grey[800] : Colors.white,
                  ),
                  child: ExpansionTile(
                    initiallyExpanded: isExpanded,
                    onExpansionChanged: (expanded) {
                      setState(() {
                        _expandedStates[index] = expanded;
                      });
                    },
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                        ),
                        SizedBox(width: 8),
                        Text(
                          info.title,
                          style: TextStyle(
                            fontFamily: 'kalpurush',
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.teal.shade200 : Colors.teal.shade700,
                          ),
                        ),
                      ],
                    ),
                    iconColor: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    collapsedIconColor: isDarkMode ? Colors.teal.shade200 : Colors.teal,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          info.description,
                          style: TextStyle(
                            fontFamily: 'kalpurush',
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}