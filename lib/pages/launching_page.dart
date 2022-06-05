import 'dart:async';
import 'dart:io';

import 'package:AMW/constants.dart';
import 'package:AMW/pages/user_launching_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../service/auth.dart';
import '../service/firebase_service.dart';
import '../service/init_data.dart';
import 'hospital_launching_page.dart';

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
          FirebaseMessaging.instance
              .subscribeToTopic(MyAuth().getCurrentUserId());
          FirebaseMessaging.instance.subscribeToTopic('all');

          return FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Scaffold(
                      body: Center(child: CircularProgressIndicator()));
                }
                return LaunchingPage();
              });
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

double latitude = 1.1;
double longitude = 1.1;

class _LaunchingPageState extends State<LaunchingPage> {
  final LocationSettings locationSettings = const LocationSettings(
      accuracy: LocationAccuracy.low, distanceFilter: 100);
  late Stream<Position> positionStream;
  // input field controller
  final TextEditingController _vnoController = TextEditingController();
  XFile? file;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    kLogger.d(InitData.owner!.userType);
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("AMW (" + InitData.owner!.userType.toUpperCase() + ")"),
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
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100),
                  const Text(
                      "Your location will be notified whenever there is any accident",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  StreamBuilder<Position>(
                      stream: positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Text(
                            "Waiting for location",
                          );
                        }
                        latitude = snapshot.data?.latitude ?? 1.1;
                        longitude = snapshot.data?.longitude ?? 1.1;
                        if (snapshot.hasData) {
                          FirestoreService().updateUserData(
                              lat: snapshot.data!.latitude,
                              lon: snapshot.data!.longitude);
                          return Text(
                              "Latitude: ${snapshot.data!.latitude.toString()}, Longitude: ${snapshot.data!.longitude.toString()}");
                        } else {
                          return const Text(
                            "Waiting for location",
                          );
                        }
                      }),
                  SizedBox(height: 100),
                ],
              ),
              InitData.owner!.userType == "user"
                  ? RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserGuidelinesPage(),
                          ),
                        );
                      },
                      child: const Text("Virtual First Aid Guidelines"),
                    )
                  : InitData.owner!.userType == "police"
                      ? Column(
                          children: [
                            SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.asset('asset/a.PNG')),
                            Form(
                                child: Column(
                              children: [
                                // raised button for camera image selection
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: file == null
                                      ? RaisedButton(
                                          onPressed: () async {
                                            final ImagePicker _picker =
                                                ImagePicker();

                                            final XFile? photo =
                                                await _picker.pickImage(
                                                    source: ImageSource.camera);
                                            setState(() {
                                              file = photo;
                                            });
                                            print(photo!.path);
                                          },
                                          child: const Text("Select Image"),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                              Text("Image Selected"),
                                              IconButton(
                                                icon: Icon(Icons.delete),
                                                onPressed: () {
                                                  setState(() {
                                                    file = null;
                                                  });
                                                },
                                              )
                                            ]),
                                ),
                                // form field - vehicle number
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Vehicle Number',
                                    ),
                                    controller: _vnoController,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // raised button for submit
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 300),
                                    child: loading
                                        ? CircularProgressIndicator()
                                        : RaisedButton(
                                            onPressed: () async {
                                              setState(() {
                                                loading = true;
                                              });
                                              bool success =
                                                  await uploadEvidence(
                                                      File(file!.path),
                                                      _vnoController.text,
                                                      latitude.toString(),
                                                      longitude.toString());
                                              if (success) {
                                                file = null;
                                                _vnoController.text = "";
                                                //show success message
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Done'),
                                                        content:
                                                            Text('Add Success'),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('Ok'),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Failed'),
                                                        content: Text(
                                                            'Unable to add'),
                                                        actions: <Widget>[
                                                          FlatButton(
                                                            child: Text('Ok'),
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              }
                                              setState(() {
                                                loading = false;
                                              });
                                            },
                                            child: const Text("Submit"),
                                          ),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        )
                      : const HospitalLaunchingPage()
            ],
          ),
        )),
      ),
    );
  }
}
