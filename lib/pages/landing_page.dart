import 'package:AMW/pages/signup_page.dart';
import 'package:AMW/widget/signinupbutton.dart';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'login_page.dart';

/// This page is loaded after the init page and shown only when unauthenticated.
/// This page shows signin and signup buttons
class LandingPageOl extends StatefulWidget {
  const LandingPageOl({Key? key}) : super(key: key);

  @override
  _LandingPageOlState createState() => _LandingPageOlState();
}

class _LandingPageOlState extends State<LandingPageOl> {
  bool googleSignUpLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
          Expanded(
            child: Stack(
              children: [
                // const TestInitPage1(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10, horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // CustomRaisedButtonWithIcon(
                      //   icon: Icon(Icons.phone),
                      //   buttonTitle: "Continue with Phone",
                      //   onPressed: () {
                      //     showInformationDialog(context);
                      //   },
                      // ),
                      // SignUPButtonWithHeading(
                      //   title: "Continue with Phone",
                      //   heading: Icon(
                      //     Icons.call,
                      //     color: Colors.white,
                      //   ),
                      //   onPressed: () {
                      //     showInformationDialog(context);
                      //   },
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      // googleSignUpLoading
                      //     ? const CircularProgressIndicator()
                      //     : SignUPButtonWithHeading(
                      //         title: "Continue with Google",
                      //         heading: Image.asset(
                      //             "assets/images/google_logo.png"),
                      //         onPressed: () async {
                      //           setState(() {
                      //             googleSignUpLoading = true;
                      //           });

                      //           await signInWithGoogle();
                      //           if (mounted) {
                      //             setState(() {
                      //               googleSignUpLoading = false;
                      //             });
                      //           } else {
                      //             googleSignUpLoading = false;
                      //           }
                      //         },
                      //       ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: SignInUpButton(
                              text: "Sign In",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));
                              },
                            ),
                          ),
                          Expanded(
                            child: SignInUpButton(
                              text: "Sign Up",
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpPage()));
                              },
                            ),
                          ),
                          // ],
                          //   ),
                        ],
                      ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}

class SignUPButtonWithHeading extends StatefulWidget {
  final Function? onPressed;
  final String? title;
  final Widget? heading;

  const SignUPButtonWithHeading(
      {Key? key, this.onPressed, this.title, this.heading})
      : super(key: key);
  @override
  _SignUPButtonWithHeadingState createState() =>
      _SignUPButtonWithHeadingState();
}

class _SignUPButtonWithHeadingState extends State<SignUPButtonWithHeading> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed as void Function()?,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(25),
            color: Colors.transparent),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: 30, child: widget.heading),
              Text(
                widget.title!,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20),
              ),
              const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    Geolocator.requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
            title: const Text('AMW'),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Sign In'),
                Tab(text: 'Sign Up'),
              ],
            )),
        body: const TabBarView(
          children: [
            LoginPage(),
            SignUpPage(),
          ],
        ),
      ),
    );
  }
}
