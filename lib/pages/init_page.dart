import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'landing_page.dart';
import 'launching_page.dart';

class InitPage extends StatefulWidget {
  const InitPage({Key? key}) : super(key: key);

  @override
  _InitPageState createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  void initializeFirebase() async {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp().whenComplete(() async {
        // await FirebaseCrashlytics.instance
        //     .setCrashlyticsCollectionEnabled(true);

        print("firebase initializedd successfully");

        await Future.delayed(const Duration(milliseconds: 800));
        setState(() {
          _d = true;
        });
        await Future.delayed(const Duration(milliseconds: 200));

        Navigator.of(context).pushReplacement(
          ThisIsFadeRoute(
            route: const CheckAuthandRedirect(),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeFirebase();
    _a = false;
    _b = false;
    _c = false;
    _d = false;
    _e = false;
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(const Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(const Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(const Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _h / 2
                      : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                      ? 80
                      : 20,
              width: _d
                  ? _w
                  : _c
                      ? 200
                      : 20,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                  // shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius: _d
                      ? const BorderRadius.only()
                      : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    ? AnimatedTextKit(
                        totalRepeatCount: 100,
                        animatedTexts: [
                          FadeAnimatedText(
                            'AMW',
                            duration: const Duration(milliseconds: 3700),
                            textStyle: const TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 30,
                              fontFamily: 'Blanka',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget? page;
  final Widget? route;

  ThisIsFadeRoute({this.page, this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page!,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}

class CheckAuthandRedirect extends StatefulWidget {
  const CheckAuthandRedirect({Key? key}) : super(key: key);

  @override
  _CheckAuthandRedirectState createState() => _CheckAuthandRedirectState();
}

class _CheckAuthandRedirectState extends State<CheckAuthandRedirect> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          print("snaphot data - ${snapshot.data}");
          if (snapshot.data != null && !snapshot.hasError) {
            // if (!MyAuth().userVerified()) {
            //   if (kWaitingForVerification) {
            //     kLogger.i("Navigating to landing page");

            //     return const LandingPage();
            //   }
            //   kLogger.i("something issue here");
            //   MyAuth.logout();
            // }

            kLogger.i("Navigating to launching page");
            return const LoadInitDataandLaunchingPage();
          } else {
            kLogger.i("Navigating to landing page");
            return const LandingPage();
          }
        }
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("in loading page");
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

Route pageRouteAnimation(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(1.0, 0.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
