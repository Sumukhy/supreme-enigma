import 'dart:async';

import 'package:accident_detection/service/auth.dart';
import 'package:accident_detection/service/firebase_service.dart';
import 'package:accident_detection/service/init_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../constants.dart';

class LoadInitDataandLaunchingPage extends StatefulWidget {
  const LoadInitDataandLaunchingPage({Key? key}) : super(key: key);

  @override
  _LoadInitDataandLaunchingPageState createState() =>
      _LoadInitDataandLaunchingPageState();
}

class _LoadInitDataandLaunchingPageState
    extends State<LoadInitDataandLaunchingPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InitData().loadInitData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // if (InitData.owner == null) {
          //   MyAuth.logout();
          //   return const Scaffold(
          //     body: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   );
          // }
          return LaunchingPage();
        } else {
          return const Scaffold(
            body: Text("Something Went wrong"),
          );
        }
      },
    );
  }
}

class LaunchingPage extends StatefulWidget {
  const LaunchingPage({Key? key}) : super(key: key);

  @override
  State<LaunchingPage> createState() => _LaunchingPageState();
}

class _LaunchingPageState extends State<LaunchingPage> {
  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low, distanceFilter: 100);
  late Stream<Position> positionStream;

  @override
  void initState() {
    super.initState();
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings);
    //         .listen((Position? position) {
    //   kLogger.d(position == null
    //       ? 'Unknown'
    //       : '${position.latitude.toString()}, ${position.longitude.toString()}');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AMW"),
        actions: [
          //logout icon
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              MyAuth.logout();
            },
          ),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
              "Your location will be notified whenever there is any accident",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),
          StreamBuilder<Position>(
              stream: positionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  FirestoreService().updateUserData(
                      lat: snapshot.data!.latitude,
                      lon: snapshot.data!.longitude);
                  return Text(
                      "Latitude: ${snapshot.data!.latitude.toString()}, Longitude: ${snapshot.data!.longitude.toString()}");
                } else {
                  return Text("Waiting for location");
                }
              }),
        ],
      )),
    );
  }
}
