// // import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'dart:convert';

// import '../constants.dart';
// import 'notification_model.dart';

// class NotificationHandler {
//   static Future<void> showNotification(RemoteMessage event) async {
//     // String? msgID;

//     /* if (event.data.containsKey('id')) {
//       msgID = event.data['id'];
//     } else {
//       msgID = event.messageId;
//     } */
//     // assert(event.data['id'] != null);
//     // assert(event.data['id'] != "");
//     // TODO: upload notification to db
//     // ProfileFirestore().uploadNotification(
//     //     event.notification!.title!, event.notification!.body!, msgID!);

//     var androidInitialize =
//         const AndroidInitializationSettings('mipmap/ic_launcher');
//     var initializationSettings =
//         InitializationSettings(android: androidInitialize);
//     FlutterLocalNotificationsPlugin localNotification =
//         FlutterLocalNotificationsPlugin();
//     localNotification.initialize(initializationSettings,
//         onSelectNotification: selectNotification);
//     NotificationModel notificationModel =
//         NotificationModel.fromJson(event.data);
//     String channelId = notificationModel.stitchProviderId.toString();
//     String channelName = notificationModel.stitchData!.type.toString();
//     kLogger.i(channelName);
//     var androidDetails = AndroidNotificationDetails(channelId, channelName,
//         groupKey: channelName,
//         channelAction: AndroidNotificationChannelAction.createIfNotExists,
//         groupAlertBehavior: GroupAlertBehavior.all,
//         enableVibration: true);
//     var generalNotificationDetails = NotificationDetails(
//       android: androidDetails,
//     );
//     await localNotification
//         .show(1, notificationModel.stitchData!.title,
//             notificationModel.stitchData!.body, generalNotificationDetails,
//             payload: json.encode(event.data))
//         .then((value) async {
//       // kLogger.i(value);
//     });
//   }

//   static Future selectNotification(String? payload) async {
//     if (payload == null) {
//       return;
//     }
//     Map mapPayload = json.decode(payload);
//     print(mapPayload);
//   }
// }
