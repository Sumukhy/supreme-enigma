import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

Future<bool?> confirmDelete(
  BuildContext context,
  String message,
) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Confirm ?"),
      content: Text(message),
      actions: [
        CustomRaisedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            buttonTitle: "Delete"),
        CustomRaisedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            buttonTitle: "Cancel"),
      ],
    ),
  );
}
