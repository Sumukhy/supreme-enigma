import 'package:cloud_firestore/cloud_firestore.dart';

import '../constants.dart';
import 'auth.dart';

class FirestoreService {
  Future<bool> addUserData(String email, String role, String uid,
      {double lat = 0, double lon = 0}) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'email': email,
        'role': role,
        'lat': lat,
        'lon': lon,
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
