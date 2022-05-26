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

Future<void> searchInMaps(String searchText) async {
  const String googleHeaderSearch = "https://www.google.com/maps/search/?api=1";
  const String searchQueryHeader = "&query=";
  //Split the string according to URL-escaped string
  //https://developers.google.com/maps/documentation/urls/url-encoding

  List<String> searchStringList = searchText.split(" ");

  String finalUrl = googleHeaderSearch + searchQueryHeader;
  int listLength = searchStringList.length;
  for (String searchString in searchStringList) {
    finalUrl = finalUrl + searchString;
    if (searchStringList.indexOf(searchString) != listLength) {
      finalUrl = finalUrl + '+';
    }
  }
  kLaunchURL(finalUrl);
}
