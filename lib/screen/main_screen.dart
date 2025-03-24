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
        break;
      case 'about':
        break;
      case 'logout':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppUtils.getTitle(_selectedIndex),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
        ),
        actions: [
          PopupMenuButton<String>(
            color: Colors.white,
            elevation: 0.1,
            onSelected: _onMenuItemSelected,
            itemBuilder:
                (BuildContext context) => [
                  PopupMenuItem<String>(
                    value: 'view',
                    child: Row(
                      children:[
                        Icon(
                          provider.gridView ? Icons.grid_view : Icons.list,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text('হোম ভিউ পরিবর্তন'),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'settings',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.settings,
                          size: 20,
                          color: Colors.black,
                        ), // Icon
                        SizedBox(width: 8), // Add spacing between icon and text
                        Text('সেটিংস'), // Text
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'about',
                    child: Row(
                      children: const [
                        Icon(Icons.info, size: 20, color: Colors.black), // Icon
                        SizedBox(width: 8), // Add spacing between icon and text
                        Text('অ্যাপ সম্পর্কে'), // Text
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          size: 20,
                          color: Colors.black,
                        ), // Icon
                        SizedBox(width: 8), // Add spacing between icon and text
                        Text('লগ আউট'), // Text
                      ],
                    ),
                  ),
                ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/village_scene.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Text(
                'ঠাকুরগাঁও জেলা',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.teal),
              title: const Text('হোম'),
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
                title: Text(option['title']),
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
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          elevation: 0, // Remove elevation (we're using shadow)
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'হোম', // Home
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.attach_money),
              label: 'ফ্রি রিচার্জ', // Earn
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'নোটিফিকেশন', // Notifications
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'প্রোফাইল', // Profile
            ),
          ],
        ),
      ),
    );
  }
}
