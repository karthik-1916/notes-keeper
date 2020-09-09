import 'dart:ui';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../main.dart';

class NotificationHelper {
  ///Shows Notification immediately when called.
  ///
  showNotification() async {
    var androidChannelSpecifics = AndroidNotificationDetails(
      'CHANNEL_ID',
      'CHANNEL_NAME',
      "CHANNEL_DESCRIPTION",
      importance: Importance.Max,
      priority: Priority.Max,
      playSound: true,
      timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidChannelSpecifics,
      iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'title',
      'body',
      platformChannelSpecifics,
      payload: 'New Payload',
    );
  }

  ///Schedule the Notification.
  ///
  ///Shows Notification on Specified time.
  ///
  ///The [selectedDate] Should be a String and Formatted as 'yyyy-mm-dd'.
  ///
  ///The [selectedTime] Should be a String and Formatted as 'HH:mm'.
  ///
  ///The [id] Should not be null and  is Unique representation of notification.
  ///
  ///
  scheduledNotification(
    String selectedDate,
    String selectedTime,
    int id,
    String title,
    String body,
  ) async {
    var scheduledNotificationDateTime = new DateTime(
        int.parse(selectedDate.substring(0, 4)),
        int.parse(selectedDate.substring(5, 7)),
        int.parse(selectedDate.substring(8, 10)),
        int.parse(selectedTime.substring(0, 2)),
        int.parse(selectedTime.substring(3, 5)));
    print(scheduledNotificationDateTime);
    var androidChannelSpecifics = AndroidNotificationDetails(
      '1',
      'Reminder',
      "Notes Reminder",
      enableLights: true,
      color: const Color.fromARGB(255, 255, 0, 0),
      ledColor: const Color.fromARGB(255, 255, 0, 0),
      ledOnMs: 1000,
      ledOffMs: 500,
      importance: Importance.Max,
      priority: Priority.High,
      playSound: true,
      // timeoutAfter: 5000,
      styleInformation: DefaultStyleInformation(true, true),
    );
    var iosChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      androidChannelSpecifics,
      iosChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.schedule(
      id,
      title,
      body,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      payload: id.toString(),
    );
  }

  deleteNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
