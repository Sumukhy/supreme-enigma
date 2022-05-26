import 'package:accident_detection/pages/init_page.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'service/notification_handler.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   kLogger.i("Handling a background message: ${message.messageId}");
//   kLogger.i("main notification id ${message.data["id"]}");
//   kLogger.i(message.data);
//   await NotificationHandler.showNotification(message);
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: kbackgroundColor,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(primary: Colors.blue))),
        home: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "AMW",
          theme: ThemeData.light().copyWith(
              scaffoldBackgroundColor: kbackgroundColor,
              elevatedButtonTheme: ElevatedButtonThemeData(
                  style: ElevatedButton.styleFrom(primary: Colors.blue))),
          home: const InitPage(),
        ));
  }
}
