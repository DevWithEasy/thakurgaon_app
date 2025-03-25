import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final String time;
  final bool read;
  final IconData icon;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.read,
    required this.icon,
  });
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final List<NotificationItem> notifications = [
      NotificationItem(
        title: 'New Message',
        message: 'You have received a new message from John Doe',
        time: '2 min ago',
        read: false,
        icon: Icons.message,
      ),
      NotificationItem(
        title: 'Payment Received',
        message: '\$250.00 payment received from Acme Inc',
        time: '1 hour ago',
        read: true,
        icon: Icons.payment,
      ),
      NotificationItem(
        title: 'Appointment Reminder',
        message: 'Dentist appointment tomorrow at 10:00 AM',
        time: '3 hours ago',
        read: true,
        icon: Icons.calendar_today,
      ),
      NotificationItem(
        title: 'New Feature',
        message: 'Check out our latest update with new features',
        time: '1 day ago',
        read: true,
        icon: Icons.update,
      ),
    ];

    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const Divider(height: 16),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Container(
            decoration: BoxDecoration(
              color: !notification.read
                  ? Colors.teal.withOpacity(0.1)
                  : isDarkMode
                      ? Colors.grey[900]
                      : Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    notification.icon,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            notification.title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Text(
                            notification.time,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.message,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white70 : Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!notification.read)
                  Container(
                    width: 8,
                    height: 8,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: const BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle mark all as read
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.done_all, color: Colors.white),
      ),
    );
  }
}