import 'package:AMW/pages/init_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'constants.dart';
import 'service/notification_handler.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  kLogger.i("Handling a background message: ${message.messageId}");
  kLogger.i("main notification id ${message.data["id"]}");
  kLogger.i(message.data);
  await NotificationHandler.showNotification(message);
}

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
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("onMessageOpenedApp: $message");

      print("show map = ${message.data["lat"]}");
      if (message.data.containsKey('bloodgroup')) {
        MapsLauncher.launchCoordinates(
            double.parse(message.data["lat"]),
            double.parse(message.data["long"]),
            "This area requests the gift of your blood(${message.data["bloodgroup"]}).");
      } else {
        MapsLauncher.launchCoordinates(double.parse(message.data["lat"]),
            double.parse(message.data["long"]), "Accident Location");
      }
    });

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
