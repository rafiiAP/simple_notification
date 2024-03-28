import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'ui/detail_page.dart';
import 'ui/home_page.dart';
import 'utils/notification_helper.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.onDeniedCallback(() async {
    await Permission.notification.request();
  }).onGrantedCallback(() {
    // Your code
  }).onPermanentlyDeniedCallback(() {
    // Your code
  }).request();
  await Permission.scheduleExactAlarm.onDeniedCallback(() async {
    await Permission.scheduleExactAlarm.request();
  }).onGrantedCallback(() {
    // Your code
  }).onPermanentlyDeniedCallback(() {
    // Your code
  }).request();

  final NotificationHelper notificationHelper = NotificationHelper();

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);
  notificationHelper.requestIOSPermissions(flutterLocalNotificationsPlugin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        DetailPage.routeName: (context) => const DetailPage(),
      },
    );
  }
}
