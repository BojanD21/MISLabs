import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationHandler {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  // Initialize Firebase Cloud Messaging
  static Future<void> initialize(BuildContext context) async {
    // Request permission for iOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission();
    print('User granted permission: ${settings.authorizationStatus}');

    // Listen to foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message: ${message.notification?.title}');
      
      // You can handle the notification here, e.g., show a dialog, navigate, etc.
      _showNotificationDialog(context, message);
    });

    // Listen to when the app is opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
      // You can navigate to a specific screen based on the notification
      // For example, navigate to the "joke details" screen
      _handleNotificationNavigation(context, message);
    });

    // Get the device FCM token
    String? token = await _firebaseMessaging.getToken();
    print("FCM Token: $token");

    // Handle background messages
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  // Handle background message (for when the app is terminated or in the background)
  static Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
    print('Handling a background message: ${message.messageId}');
  }

  // Show a notification dialog when a push notification is received in the foreground
  static void _showNotificationDialog(BuildContext context, RemoteMessage message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(message.notification?.title ?? 'No title'),
        content: Text(message.notification?.body ?? 'No body'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              _handleNotificationNavigation(context, message);
            },
            child: const Text('Open'),
          ),
        ],
      ),
    );
  }

  // Handle navigation when a notification is tapped
  static void _handleNotificationNavigation(BuildContext context, RemoteMessage message) {
    // You can navigate to specific screens based on the notification's content
    // For example:
    // if (message.data['type'] == 'joke') {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => JokeDetailsScreen(message.data['id'])),
    //   );
    // }
    print('Navigating to specific screen...');
  }
}
