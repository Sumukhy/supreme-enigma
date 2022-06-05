import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';
import 'auth.dart';

class FirestoreService {
  Future<bool> addUserData(String email, String role, String uid,
      {double lat = 0,
      double lon = 0,
      String departmentID = "",
      String familyName = "",
      String familyEmail = ""}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'role': role,
        'lat': lat,
        'lon': lon,
        'department_id': departmentID,
        "family_member_name": familyName,
        "family_email": familyEmail
      });
      return true;
    } catch (e) {
      kLogger.e(e);
      return false;
    }
  }

  Future<bool> updateUserData({double lat = 0, double lon = 0}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(MyAuth().getCurrentUserId())
          .update({
        'lat': lat,
        'lon': lon,
      });
      return true;
    } catch (e) {
      kLogger.e(e);
      return false;
    }
  }
}

Future<bool> uploadEvidence(
    File file, String vno, String lat, String lon) async {
  DateTime _now = DateTime.now();
  String timestamp =
      "${_now.day}/${_now.month}/${_now.year}  ${_now.hour}:${_now.minute}:${_now.second}.${_now.millisecond}";
  String url = await uploadFile(file);
  try {
    await FirebaseFirestore.instance.collection('evidence').doc().set({
      'vehicle_no': vno,
      'image': url,
      'lat': lat,
      'long': lon,
      "timestamp": timestamp
    });
    return true;
  } catch (e) {
    kLogger.e(e);
    return false;
  }
}

Future<String> uploadFile(File file) async {
  print(file.path);
  String filename = file.path.split("/").last;
  Reference storageRef = FirebaseStorage.instance.ref();

// Create a reference to 'images/mountains.jpg'
  Reference imgref = storageRef.child("accident/" + filename);

  TaskSnapshot uploadTask = await imgref.putFile(file);
  String url = (await imgref.getDownloadURL()).toString();

  return filename;
}
