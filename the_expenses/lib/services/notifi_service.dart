import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:the_expenses/utils/color_constants.dart';

import '../schedule_notification_model.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(null, [
      NotificationChannel(
          channelGroupKey: "basic_channel_group",
          channelKey: "basic_channel",
          channelName: "Basic Notification",
          channelDescription: "Basic Notification Channel",
          importance: NotificationImportance.Max,
          defaultPrivacy: NotificationPrivacy.Public,
          enableVibration: true,
          playSound: true,
          defaultColor: const Color(darkBlue))
    ], channelGroups: [
      NotificationChannelGroup(
          channelGroupKey: "basic_channel_group",
          channelGroupName: "Basic Group")
    ]);
  }

  static Future<void> requestPermission() async {
    bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
    initialize();
  }

  static Future<void> scheduleNotification({required Schedule schedule}) async {
    Random random = Random();
    await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
            minute: schedule.time.minute,
            hour: schedule.time.hour,
            day: schedule.time.day,
            weekday: schedule.time.weekday,
            year: schedule.time.year,
            allowWhileIdle: true,
            timeZone:
                await AwesomeNotifications().getLocalTimeZoneIdentifier()),
        actionButtons: [
          NotificationActionButton(
              key: "Close", label: "Close Reminder", autoDismissible: true)
        ],
        content: NotificationContent(
            id: random.nextInt(1000000) + 1,
            channelKey: "basic_channel",
            title: "Expense Reminder",
            body: schedule.details,
            category: NotificationCategory.Reminder,
            notificationLayout: NotificationLayout.BigText,
            wakeUpScreen: true,
            autoDismissible: false,
            fullScreenIntent: true,
            backgroundColor: const Color(darkBlue)));
  }
}

class NotificationController {
  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    print("notification is shcedule");

  }
  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    print("notification is displayed");
    NotificationService.scheduleNotification(
        schedule: Schedule(
            details: "Track Your Expenses in The Expenses",
            time: DateTime.now().add(const Duration(days: 1))));
  }

  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("notification is dismissed");
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    print("notification is tapped");
  }
}
