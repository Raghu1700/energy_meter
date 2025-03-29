import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement notification settings
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildNotificationCard(
            context,
            'High Energy Usage Alert',
            'Your AC consumption is 40% higher than usual',
            Icons.warning_amber_rounded,
            Colors.orange,
            DateTime.now().subtract(const Duration(hours: 1)),
          ),
          _buildNotificationCard(
            context,
            'Bill Payment Reminder',
            'Your estimated bill for this month is ₹3,450',
            Icons.payment,
            Theme.of(context).colorScheme.primary,
            DateTime.now().subtract(const Duration(hours: 3)),
          ),
          _buildNotificationCard(
            context,
            'Energy Saving Tip',
            'Switch off AC and use fans during moderate weather',
            Icons.tips_and_updates,
            Colors.green,
            DateTime.now().subtract(const Duration(hours: 5)),
          ),
          _buildNotificationCard(
            context,
            'Peak Hours Alert',
            'You are entering peak hours (6 PM - 10 PM). Usage rates will be higher.',
            Icons.access_time,
            Colors.purple,
            DateTime.now().subtract(const Duration(days: 1)),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    String title,
    String message,
    IconData icon,
    Color color,
    DateTime time,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: color,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(message),
            const SizedBox(height: 4),
            Text(
              _getTimeAgo(time),
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
