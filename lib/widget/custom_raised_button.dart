import 'package:flutter/material.dart';

class CustomRaisedButtonWithIcon extends StatelessWidget {
  final String buttonTitle;
  final Function onPressed;
  final Icon icon;

  const CustomRaisedButtonWithIcon({
    required this.onPressed,
    required this.buttonTitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          icon,
          Text(
            buttonTitle,
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 5,
          )
        ],
      ),
    );
  }
}

class CustomRaisedButton extends StatelessWidget {
  final String buttonTitle;
  final Function? onPressed;

  const CustomRaisedButton(
      {required this.onPressed, required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed as void Function()?,
      child: Text(
        buttonTitle,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
