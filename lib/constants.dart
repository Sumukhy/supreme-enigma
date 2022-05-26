import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

bool kWaitingForVerification = false;

var kLogger = Logger();

void kLaunchURL(String url) async {
  assert(url.isNotEmpty);
  await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

var kbuttonbgcolor = "0xFF0000FF";

Pattern kEmailPattern = r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$";

var kbackgroundColor = const Color(0xffB9E0E7);
