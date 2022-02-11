
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';



//import 'package:device_info/device_info.dart';


class NotificationService {


 static FlutterLocalNotificationsPlugin _notifications = new FlutterLocalNotificationsPlugin();

  static final BehaviorSubject<String?> LocalNotificationSelect = new BehaviorSubject<String>();

  static const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');


  static const IOSInitializationSettings initializationSettingsIOS =
  IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  static const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);

  static void initialize() async {
    await _notifications.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
        LocalNotificationSelect.add(payload);
      });

  }



   static Future _notificationsDeatils() async {
      return NotificationDetails(
        android: AndroidNotificationDetails(
            'Channel id',
            'Channel name',
            channelDescription: "..",
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails(),
      );
    }


   static Future showNotify({
      int id = 0,
      String?title,
      String?body,
      String?payload,
    }) async =>
        _notifications.show(
          id,
          title,
          body,
          await _notificationsDeatils(),
          payload: payload,
        );

}