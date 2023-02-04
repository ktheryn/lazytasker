import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:lazytasker/tasking/screen/tasker.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class NotifyHelper {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  initializeNotification(BuildContext context) async {
    _configureLocalTimeZone();
    final AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('icons');
    // final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    //   onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    // );
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: null,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          selectNotification(payload!, context);
        });
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future selectNotification(String payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    await Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen(payload)));
  }

  Future<void>showNotification(int idValue, String titleValue, String dateValue) async {
    DateTime currentTime;
    DateTime timerInSeconds;
    int timediffInseconds;
    currentTime = DateTime.now();
    timerInSeconds = DateFormat("yyyy-MM-dd HH:mm").parse(dateValue, false);
    timediffInseconds = (timerInSeconds).difference(currentTime).inSeconds;
    double minutesToPrint = 0;
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        idValue,
        titleValue,
        dateValue,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: (timediffInseconds))),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
    minutesToPrint = timediffInseconds / 60;
    print("Notification scheduled for $minutesToPrint minutes or $timediffInseconds seconds from now.");
  }




}