import 'package:flutter/material.dart';
import '../../widgets/common/top_header_widget.dart';
import '../../theme/app_colors.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  final List<NotificationData> _notifications = [
    NotificationData(
      id: '1',
      title: 'Trip Reminder',
      message: 'Your trip to Goa starts tomorrow! Don\'t forget to pack your essentials.',
      fullMessage: 'Your exciting trip to Goa starts tomorrow at 8:00 AM! Don\'t forget to pack your essentials including:\n\n• Valid ID documents\n• Camera for memories\n• Sunscreen and beach wear\n• Comfortable walking shoes\n• Medicines if any\n\nWeather forecast shows sunny skies perfect for your beach adventure. Have a safe and wonderful journey!',
      type: NotificationType.reminder,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      isRead: false,
    ),
    NotificationData(
      id: '2',
      title: 'Safety Alert',
      message: 'Heavy rainfall expected in your current location. Please stay indoors if possible.',
      fullMessage: 'Weather Alert: Heavy rainfall expected in your current location (Mumbai) from 6:00 PM today till 10:00 AM tomorrow.\n\nSafety Recommendations:\n• Avoid unnecessary travel\n• Stay indoors if possible\n• Keep emergency contacts handy\n• Charge your devices\n• Stock up on essentials\n\nIn case of emergency, use the SOS feature in the app. Local emergency services: 100, 101, 108\n\nStay safe and dry!',
      type: NotificationType.safety,
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      isRead: false,
    ),
    NotificationData(
      id: '3',
      title: 'Group Update',
      message: 'John added 3 new photos to your Shimla Trip album.',
      fullMessage: 'John Smith has added 3 new photos to your "Shimla Adventure 2025" trip album!\n\nNew photos include:\n• Sunrise view from Mall Road\n• Group photo at Jakhu Temple\n• Evening at Ridge Ground\n\nYou can view and download these photos from the trip gallery. Don\'t forget to add your own memories to the shared album!\n\nTrip members can also add comments and reactions to the photos.',
      type: NotificationType.group,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      isRead: true,
    ),
    NotificationData(
      id: '4',
      title: 'System Update',
      message: 'Yatra Guardian app has been updated with new features and improvements.',
      fullMessage: 'Yatra Guardian v2.1.0 Update\n\nWhat\'s New:\n• Enhanced emergency response system\n• Improved location sharing accuracy\n• New offline maps feature\n• Better battery optimization\n• Updated safety guidelines\n• Bug fixes and performance improvements\n\nThe app will automatically restart to apply updates. All your data and trip information will remain safe.\n\nThank you for using Yatra Guardian!',
      type: NotificationType.system,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      isRead: true,
    ),
    NotificationData(
      id: '5',
      title: 'Emergency Alert',
      message: 'SOS signal detected from your group member Sarah. Location: Manali Highway.',
      fullMessage: 'EMERGENCY ALERT\n\nSOS signal detected from your group member Sarah Johnson.\n\nDetails:\n• Time: Today at 3:45 PM\n• Location: Manali Highway, Near Kullu\n• GPS Coordinates: 32.2396° N, 77.1887° E\n• Signal Type: Manual SOS activation\n\nActions Taken:\n• Local emergency services notified\n• Group members alerted\n• Last known location shared\n• Emergency contacts informed\n\nIf you are nearby, please check on Sarah immediately. If you cannot reach the location, contact local police: 100\n\nThis is an active emergency situation.',
      type: NotificationType.emergency,
      timestamp: DateTime.now().subtract(const Duration(hours: 6)),
      isRead: false,
    ),
    NotificationData(
      id: '6',
      title: 'Travel Tips',
      message: 'Check out the latest travel guidelines for your upcoming destinations.',
      fullMessage: 'Latest Travel Guidelines & Tips\n\nBased on your upcoming trips, here are the latest guidelines:\n\nFor Goa:\n• Beach safety: Strong currents reported at Baga Beach\n• Local transport: Pre-book taxis for airport transfers\n• Weather: Perfect time for water sports\n\nFor Manali:\n• Road conditions: Highway clear, minimal traffic\n• Temperature: Carry warm clothes for evenings\n• Permits: No special permits required\n\nGeneral Tips:\n• Keep digital copies of important documents\n• Share your itinerary with family\n• Download offline maps\n• Carry portable chargers\n\nHave a wonderful and safe journey!',
      type: NotificationType.info,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      isRead: true,
    ),
  ];

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      body: SafeArea(
        child: Column(
          children: [
            TopHeaderWidget(onBackground: AppColors.onBackground),
            _buildHeader(),
            Expanded(
              child: _notifications.isEmpty
                  ? _buildEmptyState()
                  : _buildNotificationsList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final unreadCount = _notifications.where((n) => !n.isRead).length;
    
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            Icons.notifications_active,
            color: AppColors.accent,
            size: 28,
          ),
          const SizedBox(width: 12),
          Text(
            'Notifications',
            style: TextStyle(
              color: AppColors.onBackground,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          if (unreadCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$unreadCount new',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: AppColors.muted,
          ),
          const SizedBox(height: 16),
          Text(
            'No notifications yet',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You\'ll see important updates here',
            style: TextStyle(
              color: AppColors.muted,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _notifications.length,
      itemBuilder: (context, index) {
        final notification = _notifications[index];
        final isExpanded = _expandedIndex == index;
        
        return _buildNotificationCard(notification, index, isExpanded);
      },
    );
  }

  Widget _buildNotificationCard(NotificationData notification, int index, bool isExpanded) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: !notification.isRead 
            ? Border.all(color: AppColors.accent.withOpacity(0.3), width: 1)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                if (_expandedIndex == index) {
                  _expandedIndex = null;
                } else {
                  _expandedIndex = index;
                  // Mark as read when expanded
                  if (!notification.isRead) {
                    notification.isRead = true;
                  }
                }
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildNotificationIcon(notification.type),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  color: AppColors.onBackground,
                                  fontSize: 16,
                                  fontWeight: notification.isRead 
                                      ? FontWeight.w600 
                                      : FontWeight.w700,
                                ),
                              ),
                            ),
                            if (!notification.isRead)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: isExpanded ? null : 2,
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              _formatTimestamp(notification.timestamp),
                              style: TextStyle(
                                color: AppColors.muted,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const Spacer(),
                            Icon(
                              isExpanded 
                                  ? Icons.expand_less 
                                  : Icons.expand_more,
                              color: AppColors.muted,
                              size: 20,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: AppColors.muted.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  Text(
                    notification.fullMessage,
                    style: TextStyle(
                      color: AppColors.onBackground,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                  ),
                  if (notification.type == NotificationType.emergency)
                    const SizedBox(height: 16),
                  if (notification.type == NotificationType.emergency)
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Calling emergency services...'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            },
                            icon: const Icon(Icons.phone, size: 18),
                            label: const Text('Call Emergency'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Opening location in maps...'),
                                ),
                              );
                            },
                            icon: const Icon(Icons.location_on, size: 18),
                            label: const Text('View Location'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.accent,
                              side: BorderSide(color: AppColors.accent),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNotificationIcon(NotificationType type) {
    IconData icon;
    Color color;
    
    switch (type) {
      case NotificationType.emergency:
        icon = Icons.emergency;
        color = Colors.red;
        break;
      case NotificationType.safety:
        icon = Icons.warning;
        color = Colors.orange;
        break;
      case NotificationType.reminder:
        icon = Icons.schedule;
        color = AppColors.accent;
        break;
      case NotificationType.group:
        icon = Icons.group;
        color = Colors.purple;
        break;
      case NotificationType.system:
        icon = Icons.system_update;
        color = Colors.green;
        break;
      case NotificationType.info:
        icon = Icons.info;
        color = AppColors.muted;
        break;
    }
    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

class NotificationData {
  final String id;
  final String title;
  final String message;
  final String fullMessage;
  final NotificationType type;
  final DateTime timestamp;
  bool isRead;

  NotificationData({
    required this.id,
    required this.title,
    required this.message,
    required this.fullMessage,
    required this.type,
    required this.timestamp,
    this.isRead = false,
  });
}

enum NotificationType {
  emergency,
  safety,
  reminder,
  group,
  system,
  info,
}