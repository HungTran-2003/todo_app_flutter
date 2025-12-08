import 'dart:async';
import 'dart:developer';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/models/entities/todo_entity.dart';

abstract class NotificationRepository {
  Future<void> init();

  Future<void> syncTodoNotifications(List<TodoEntity> todos, String body);

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  });

  Future<void> cancelNotification(int id);

  Future<void> cancelAll();

  Stream<String?> get onNotificationClick;
}

class NotificationRepositoryImpl implements NotificationRepository {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  final StreamController<String?> _controller =
      StreamController<String?>.broadcast();

  @override
  Stream<String?> get onNotificationClick => _controller.stream;

  @override
  Future<void> init() async {
    tz.initializeTimeZones();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();

    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initIOS = DarwinInitializationSettings();
    const InitializationSettings settings = InitializationSettings(
      android: initAndroid,
      iOS: initIOS,
    );

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.payload != null) {
          _controller.add(response.payload);
        }
      },
    );
  }

  @override
  Future<void> syncTodoNotifications(List<TodoEntity> todos, String body) async {
    for (final todo in todos) {
      if(todo.id == null) continue;
      log(todo.id.toString());
      await scheduleNotification(id: todo.id!, title: todo.title, body: body, scheduledDate: todo.duaDate);
    }
  }

  @override
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledDate,
    String? payload,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'schedule_channel',
          'Scheduled Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final tz.TZDateTime tzDate = tz.TZDateTime.from(scheduledDate, tz.local);

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
      matchDateTimeComponents: null,
    );
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _plugin.cancel(id);
  }

  @override
  Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    log("showNotification");
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'main_channel',
          'Main Channel',
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );
    await _plugin.show(id, title, body, details, payload: payload);
  }
}
