import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/app_provider.dart';
import '../utils/app_utils.dart';
import 'earn_screen.dart';
import 'home_screen.dart';
import 'user_screen/notifications_screen.dart';
import 'user_screen/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final screens = [
    const HomeScreen(),
    const EarnScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  final List _options = [
    {'icon': Icons.contact_support, 'title': 'যোগাযোগ', 'route': '/contact'},
    {'icon': Icons.privacy_tip, 'title': 'গোপনীয়তা নীতি', 'route': '/privacy'},
    {'icon': Icons.rule_sharp, 'title': 'পরিষেবার শর্তাবলী', 'route': '/terms'},
    {'icon': Icons.heat_pump_rounded, 'title': 'কৃতজ্ঞতা', 'route': '/thanks'},
    {'icon': Icons.developer_board, 'title': 'ডেভেলপার', 'route': '/developer'},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onMenuItemSelected(String value) {
    switch (value) {
      case 'view':
        final provider = Provider.of<AppProvider>(context, listen: false);
        provider.toggleGridView();
        break;
      case 'settings':
        Navigator.pushNamed(context, '/settings');
        break;
      case 'about':
        break;
      case 'logout':
        break;
      case 'theme':
        final provider = Provider.of<AppProvider>(context, listen: false);
        provider.toggleTheme(provider.themeMode != ThemeMode.dark);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    final isDarkMode = provider.themeMode == ThemeMode.dark;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppUtils.getTitle(_selectedIndex),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: isDarkMode ? Colors.grey[800] : Colors.white,
            elevation: 0.1,
            onSelected: _onMenuItemSelected,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'view',
                child: Row(
                  children: [
                    Icon(
                      provider.gridView ? Icons.grid_view : Icons.list,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'হোম ভিউ পরিবর্তন',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'theme',
                child: Row(
                  children: [
                    Icon(
                      isDarkMode ? Icons.light_mode : Icons.dark_mode,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isDarkMode ? 'লাইট থিম' : 'ডার্ক থিম',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'settings',
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'সেটিংস',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'about',
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'অ্যাপ সম্পর্কে',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'logout',
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'লগ আউট',
                      style: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey[800] : Colors.teal,
                image: const DecorationImage(
                        image: AssetImage('assets/images/village_scene.png'),
                        fit: BoxFit.cover,
                      ),
              ),
              child: Text(
                'ঠাকুরগাঁও জেলা',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.teal),
              title: Text(
                'হোম',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            ..._options.map((option) {
              return ListTile(
                leading: Icon(option['icon'], color: Colors.teal),
                title: Text(
                  option['title'],
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, option['route']);
                },
              );
            }),
          ],
        ),
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0.2,
              blurRadius: 1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: isDarkMode ? Colors.grey[900] : Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: isDarkMode ? Colors.grey[400] : Colors.grey,
          showUnselectedLabels: true,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'হোম',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'ফ্রি রিচার্জ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'নোটিফিকেশন',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'প্রোফাইল',
            ),
          ],
        ),
      ),
    );
  }
}