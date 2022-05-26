import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showErrorDialog(String title, String description) {
  assert(title.isNotEmpty);
  assert(description.isNotEmpty);

  Get.generalDialog(
      barrierDismissible: true,
      barrierLabel: "Error",
      pageBuilder: (conext, a, s) {
        return AlertDialog(
          title: Text(title),
          content: Text(description),
        );
      });
}
