import 'dart:ui';

import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

bool kWaitingForVerification = false;

var kLogger = Logger();

void kLaunchURL(String url) async {
  assert(url.isNotEmpty);
  kLogger.i("Launching url: $url");
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

Future<void> loadMaps(String lat, String long) async {
  const String googleHeaderSearch = "https://www.google.com/maps/search/?api=1";
  const String searchQueryHeader = "&query=";
  //Split the string according to URL-escaped string
  //https://developers.google.com/maps/documentation/urls/url-encoding

  String finalUrl = googleHeaderSearch + searchQueryHeader;
  finalUrl = finalUrl + lat + ',' + long;
  kLaunchURL(finalUrl);
}

class MapsLauncher {
  static String createQueryUrl(String query) {
    var uri;

    if (kIsWeb) {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': query});
    } else if (Platform.isAndroid) {
      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      uri = Uri.https('maps.apple.com', '/', {'q': query});
    } else {
      uri = Uri.https(
          'www.google.com', '/maps/search/', {'api': '1', 'query': query});
    }

    return uri.toString();
  }

  static String createCoordinatesUrl(double latitude, double longitude,
      [String? label]) {
    var uri;

    if (kIsWeb) {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$latitude,$longitude'});
    } else if (Platform.isAndroid) {
      var query = '$latitude,$longitude';

      if (label != null) query += '($label)';

      uri = Uri(scheme: 'geo', host: '0,0', queryParameters: {'q': query});
    } else if (Platform.isIOS) {
      var params = {'ll': '$latitude,$longitude'};

      if (label != null) params['q'] = label;

      uri = Uri.https('maps.apple.com', '/', params);
    } else {
      uri = Uri.https('www.google.com', '/maps/search/',
          {'api': '1', 'query': '$latitude,$longitude'});
    }

    return uri.toString();
  }

  static Future<bool> launchQuery(String query) {
    return launch(createQueryUrl(query));
  }

  static Future<bool> launchCoordinates(double latitude, double longitude,
      [String? label]) {
    return launch(createCoordinatesUrl(latitude, longitude, label));
  }
}
