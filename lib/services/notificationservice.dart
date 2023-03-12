import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Feedback:
/// 1. Create an asynchronous initializer using static functions
/// 2. Notification details is constant so it should be in the showNotification function
/// 3. For showNotification, title and body should be required
/// 4. You need to do platform-specific setup for local notifications and request for permissions
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin;
  NotificationService._({required this.notificationsPlugin});

  static Future<NotificationService> initNotification() async {
    final notificationsPlugin = FlutterLocalNotificationsPlugin();

    // You need to create the logo using Android Studio, otherwise it will look weird
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('logo');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    // Request notification permission
    if (Platform.isAndroid) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    } else if (Platform.isIOS) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions(sound: true, alert: true, badge: true);
    }

    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
    return NotificationService._(notificationsPlugin: notificationsPlugin);
  }

  Future showNotification(
      {int id = 0, required String title, required String? body}) async {
    const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
    return notificationsPlugin.show(id, title, body, notificationDetails);
  }
}
