import 'package:flutter/material.dart';
import 'package:thakurgaon/utils/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final cardColor = isDarkMode ? Colors.grey[900] : Colors.white;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              height: 220,
              decoration: BoxDecoration(
                color: Colors.teal,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/41.jpg',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'John Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'john.doe@example.com',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 20,
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.white),
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.editProfile);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Profile Stats
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem('Orders', '24', context),
                  _buildStatItem('Points', '1,250', context),
                  _buildStatItem('Reviews', '18', context),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildProfileOption(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    onTap: () {},
                    context: context,
                  ),
                  _buildProfileOption(
                    icon: Icons.location_on_outlined,
                    title: 'Shipping Addresses',
                    onTap: () {},
                    context: context,
                  ),
                  _buildProfileOption(
                    icon: Icons.payment_outlined,
                    title: 'Payment Methods',
                    onTap: () {},
                    context: context,
                  ),
                  _buildProfileOption(
                    icon: Icons.settings_outlined,
                    title: 'Settings',
                    onTap: () {},
                    context: context,
                  ),
                  _buildProfileOption(
                    icon: Icons.help_outline,
                    title: 'Help Center',
                    onTap: () {},
                    context: context,
                  ),
                  _buildProfileOption(
                    icon: Icons.logout_outlined,
                    title: 'Log Out',
                    onTap: () {
                      _showLogoutDialog(context);
                    },
                    context: context,
                    isLogout: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required BuildContext context,
    bool isLogout = false,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: Theme.of(context).cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isLogout 
                ? Colors.red.withOpacity(0.1)
                : Colors.teal.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: isLogout ? Colors.red : Colors.teal,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Theme.of(context).textTheme.titleMedium?.color,
          ),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Handle logout
              Navigator.pop(context);
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}