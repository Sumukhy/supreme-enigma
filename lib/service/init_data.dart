import 'package:accident_detection/constants.dart';
import 'package:accident_detection/models/user_data.dart';
import 'package:accident_detection/widget/show_error_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth.dart';

class InitData {
  static UserData? owner;

  Future<InitData> loadInitData() async {
    if (owner != null) {
      return this;
    }
    await getUserData();
    kLogger.i(owner);
    return this;
  }

  Future<InitData> reloadOwner() async {
    clearAll();
    loadInitData();
    return this;
  }

  void clearAll() {
    owner = null;
  }
}

Future<UserData?> getUserData() async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(MyAuth().getCurrentUserId())
      .get()
      .then((value) {
    if (value.exists) {
      kLogger.d(value.data());
      InitData.owner = UserData.fromJson(value.data()!);
      return InitData.owner;
    }
  });
}
