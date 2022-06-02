import 'dart:async';
import 'package:accident_detection/widget/custom_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'firebase_service.dart';
import 'init_data.dart';

/// For managing the authentications
class MyAuth {
  FirebaseAuth myAuthInstance = FirebaseAuth.instance;

  User? getCurrentUser() {
    return myAuthInstance.currentUser;
  }

  String getCurrentUserId() {
    return getCurrentUser()!.uid;
  }

  bool userVerified() {
    return getCurrentUser()!.emailVerified;
  }

  Future sendEmailVerification() async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
  }

  String? getUserEmailID() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  Future<bool> signUpWithEmail(
      BuildContext context,
      String email,
      String password,
      String role,
      String departmentID,
      String familyName,
      String familyEmail) async {
    bool signUpStatus;
    kWaitingForVerification = true;
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirestoreService().addUserData(email, role, user.user!.uid,
          departmentID: departmentID,
          familyEmail: familyEmail,
          familyName: familyName);
      // await FirebaseAuth.instance.currentUser!.sendEmailVerification();
      signUpStatus = true;
    } on FirebaseAuthException catch (error) {
      print(error.code);
      switch (error.code) {
        case "email-already-in-use":
          showCustomDialog(context, "Failed",
              "Your already have an account with this Email Id. You can login with your credentials.");
          break;
        case "invalid-email":
          showCustomDialog(context, "Failed", "Please enter a valid Email ID.");
          break;
        case "weak-password":
          showCustomDialog(
              context, "Failed", "Please choose a strong Password.");
          break;
        case "operation-not-allowed":
          showCustomDialog(context, "Failed",
              "Problem with our servers. Please try after sometime.");
          break;
      }
      signUpStatus = false;
    }
    kWaitingForVerification = false;
    return signUpStatus;
  }

  Future<bool> signInWithEmail(
      BuildContext context, String email, String password) async {
    bool signInStatus;
    kWaitingForVerification = true;
    try {
      final user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (user.user!.emailVerified) {
      print("login success");

      signInStatus = true;
      // } else {
      //   await showCustomDialog(context, "Verify the email",
      //       "You have not verified the email id yet. Please verify the email id and login again.",
      //       additionalChild: TextButton(
      //           onPressed: () async {
      //             Navigator.pop(context);
      //             await FirebaseAuth.instance.currentUser!
      //                 .sendEmailVerification()
      //                 .then((value) {
      //               showCustomDialog(context, "Verify the email",
      //                   "We have sent the new verification Mail. please verify it and login again.");
      //             }).onError((Error error, stackTrace) {
      //               showCustomDialog(context, "Failed", error.toString());
      //             });
      //           },
      //           child: const Text("Resend link")));

      //   FirebaseAuth.instance.signOut();
      //   signInStatus = false;
      // }
    } on FirebaseAuthException catch (e) {
      print(e);
      switch (e.code) {
        case "invalid-email":
          showCustomDialog(context, "Failed", "Please enter a valid Email ID.");
          break;
        case "user-disabled":
          showCustomDialog(
              context, "Disabled", "Your account has been disabled.");
          break;
        case "user-not-found":
          showCustomDialog(context, "No account found",
              "You don't have any account with this email. Please sign up in the signup page.");
          break;
        case "wrong-password":
          showCustomDialog(context, "Wrong Password",
              "Please enter the correct password. If you have forgotten the password reset it.");
          break;
      }
      signInStatus = false;
    }
    kWaitingForVerification = false;
    return signInStatus;
  }

  Future<bool> sendResetLink(BuildContext context, String forgotEmailId) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: forgotEmailId);
      return true;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      switch (e.code) {
        case "user-not-found":
          showCustomDialog(context, "No User", "No user with this account.");
          break;
        case "invalid-email":
          showCustomDialog(
              context, "Invalid Email", "Enter the proper email id");
          break;
        case "user-disabled":
          showCustomDialog(
              context, "Account Disabled", "Your account has been disabled.");
          break;
        default:
          print("Unknown error");
          showCustomDialog(context, e.code, "Unknown error");
      }

      return false;
    }
  }

  static Future<void> logout() async {
    kLogger.d("Logout event occured");

    FirebaseMessaging.instance
        .unsubscribeFromTopic(MyAuth().getCurrentUserId());

    FirebaseMessaging.instance.unsubscribeFromTopic('all');

    InitData().clearAll();

    await FirebaseAuth.instance.signOut();
    // navigate to landing page

    kLogger.d("Logout Sucessfull");
  }
}
