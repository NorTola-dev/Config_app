import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController {
  static FlutterLocalNotificationsPlugin notification =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    try {
    final timeZome = await FlutterTimezone.getLocalTimezone();

    print("DEVICE TIMEZONE: ${timeZome}"); 

    tz.setLocalLocation(tz.getLocation('$timeZome'));

    print("Timezone: $timeZome}");
  } catch (e) {
    tz.setLocalLocation(tz.getLocation('Asia/Phnom_Penh'));
  }

    var androidSetting = AndroidInitializationSettings('@mipmap/ic_launcher');

    var initSettings = InitializationSettings(android: androidSetting);

    await notification.initialize(settings: initSettings);

    await notification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();

        await notification
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestExactAlarmsPermission();
  }

  static Future<void> showNotification() async {
    var androidDetail = AndroidNotificationDetails(
      'reminder_notification',
      'reminder',
      priority: Priority.high,
      importance: Importance.high,
    );

    var detail = NotificationDetails(android: androidDetail);

    await notification.show(
      id: 1,
      title: "My Notification",
      body: "Check Your Homework",
      notificationDetails: detail,
    );
  }

  static Future<void> showNotificationSchedule(DateTime date) async {
    var androidDetail = AndroidNotificationDetails(
      'reminder_notification',
      'reminder',
      priority: Priority.high,
      importance: Importance.high,
    );

    var detail = NotificationDetails(android: androidDetail);

    var tzDatetime = tz.TZDateTime.from(date, tz.local);

    await notification.zonedSchedule(
      id: 3,
      title: "My Notification",
      body: "Alarm $date",
      scheduledDate: tzDatetime,
      notificationDetails: detail,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }
}
