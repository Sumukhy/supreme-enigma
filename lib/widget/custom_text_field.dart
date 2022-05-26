import 'package:flutter/material.dart';

class CustomAuthTextField extends StatelessWidget {
  final bool passwordProtect;
  final Function onChanged;
  final String hintText;
  final Icon icon;
  const CustomAuthTextField(
      {this.passwordProtect = false,
      required this.onChanged,
      required this.hintText,
      required this.icon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: passwordProtect,
      textCapitalization: TextCapitalization.sentences,
      onChanged: onChanged as void Function(String)?,
      decoration: InputDecoration(
        hintText: hintText,
        icon: icon,
      ),
    );
  }
}
