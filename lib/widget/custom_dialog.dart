import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> showCustomDialog(
    BuildContext context, String title, String description,
    {Widget? additionalChild}) async {
  assert(title.isNotEmpty);
  assert(description.isNotEmpty);
  double dialogBorderRadius = 20;
  double circularAvatarRadius = 45;
  await showDialog(
    context: context,
    builder: (context1) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(dialogBorderRadius),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              left: dialogBorderRadius,
              top: dialogBorderRadius + circularAvatarRadius,
              right: dialogBorderRadius,
              bottom: dialogBorderRadius),
          margin: EdgeInsets.only(top: circularAvatarRadius),
          width: kIsWeb ? 400 : 320,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(dialogBorderRadius),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 22,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                    onPressed: () {
                      Navigator.of(context1).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        additionalChild ?? const SizedBox(),
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "ok",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        // Positioned(
        //     left: dialogBorderRadius,
        //     right: dialogBorderRadius,
        //     child: CircleAvatar(
        //       radius: circularAvatarRadius,
        //       child: const ClipRRect(
        //         child: Icon(
        //           Aeronutsicon.aeronutsIcon,
        //           size: 65,
        //         ),
        //       ),
        //     )),
      ]),
    ),
  );
}
