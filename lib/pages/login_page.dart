import 'package:AMW/pages/signup_page.dart';
import 'package:AMW/service/auth.dart';
import 'package:AMW/widget/custom_raised_button.dart';
import 'package:AMW/widget/custom_text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../widget/custom_dialog.dart';
import 'launching_page.dart';

TextEditingController userEmailController = TextEditingController();

/// This is a Login Page
class LoginPage extends StatefulWidget {
  final String? autofillEmail;

  const LoginPage({Key? key, this.autofillEmail}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? forgotEmailId;
  final _formKey = GlobalKey<FormState>();
  bool _hidePasswordView = true;

  final TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    // kLogger.i(widget.autofillEmail);
    if (widget.autofillEmail != null) {
      userEmailController.text = widget.autofillEmail!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.next,
                                  decoration: customInputDecoration(
                                      "Email",
                                      const Opacity(
                                          opacity: 0,
                                          child: Icon(Icons.visibility)),
                                      const Icon(Icons.email)),
                                  keyboardType: TextInputType.emailAddress,
                                  controller: userEmailController,
                                  validator: (val) {
                                    RegExp regex =
                                        RegExp(kEmailPattern as String);
                                    if (val!.isEmpty) {
                                      return "Please enter email";
                                    } else if (!regex.hasMatch(val)) {
                                      return "Please enter valid email";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  decoration: customInputDecoration(
                                      "Password",
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            _hidePasswordView =
                                                _hidePasswordView
                                                    ? false
                                                    : true;
                                          });
                                        },
                                        child: Icon(_hidePasswordView
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                      ),
                                      const Icon(Icons.lock)),
                                  obscureText: _hidePasswordView,
                                  controller: _password,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter password";
                                    } else if (val.length <= 7) {
                                      return "Your password should be more then 8 char long";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 20.0),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    child: const Padding(
                                      padding: EdgeInsets.all(6.0),
                                      child: Text("Forgot Password ?",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                          )),
                                    ),
                                    onTap: () {
                                      print("Forgot password");

                                      showModalBottomSheet(
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (context) => Wrap(
                                          children: [
                                            SafeArea(
                                              child: ProgressHUD(
                                                child: Builder(
                                                  builder: (context) => Padding(
                                                    padding:
                                                        MediaQuery.of(context)
                                                            .viewInsets,
                                                    child: Wrap(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(30),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              const Text(
                                                                "Forgot Password",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 35,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              const Text(
                                                                  "Enter the Email ID of your account which you want to reset password."),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              CustomAuthTextField(
                                                                hintText:
                                                                    "Email ID",
                                                                onChanged:
                                                                    (value) {
                                                                  forgotEmailId =
                                                                      value;
                                                                },
                                                                icon: const Icon(
                                                                    Icons.mail),
                                                              ),
                                                              const SizedBox(
                                                                height: 20,
                                                              ),
                                                              CustomRaisedButton(
                                                                onPressed:
                                                                    () async {
                                                                  if (forgotEmailId !=
                                                                      null) {
                                                                    final progress =
                                                                        ProgressHUD.of(
                                                                            context)!;
                                                                    progress.showWithText(
                                                                        'Loading...');

                                                                    bool a = await MyAuth().sendResetLink(
                                                                        context,
                                                                        forgotEmailId!);

                                                                    progress
                                                                        .dismiss();

                                                                    if (a) {
                                                                      kLogger.i(
                                                                          "[Password Reset Page] password reset link sent for $forgotEmailId");
                                                                      forgotEmailId =
                                                                          "";
                                                                      Navigator.pop(
                                                                          context);
                                                                      showCustomDialog(
                                                                          context,
                                                                          "Reset Link sent",
                                                                          "You have received an email to reset your password.");
                                                                    }
                                                                  } else {
                                                                    showCustomDialog(
                                                                        context,
                                                                        "Error",
                                                                        "Unable to send password reset link.");
                                                                  }
                                                                },
                                                                buttonTitle:
                                                                    "Reset",
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              CustomRaisedButton(
                                buttonTitle: "Sign In",
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();

                                    final progress = ProgressHUD.of(context)!;
                                    progress.showWithText('Loading...');
                                    bool isSuccess = await MyAuth()
                                        .signInWithEmail(
                                            context,
                                            userEmailController.text,
                                            _password.text);
                                    progress.dismiss();
                                    if (isSuccess) {
                                      userEmailController.text = "";
                                      Get.to(() => LaunchingPage());
                                      // Navigator.pop(
                                      //     context); // don't remove or else it won't redirect to launching page
                                    }
                                  }
                                },
                              ),
                              // kReleaseMode
                              //     ? const SizedBox()
                              //     : CustomRaisedButton(
                              //         buttonTitle: "Admin Sign In",
                              //         onPressed: () async {
                              //           final progress =
                              //               ProgressHUD.of(context)!;
                              //           progress.showWithText('Loading...');
                              //           bool isSuccess = await MyAuth()
                              //               .signInWithEmail(
                              //                   context,
                              //                   "aeronauts.developer@gmail.com",
                              //                   "aeronuts@123");
                              //           progress.dismiss();
                              //           if (isSuccess) {
                              //             Navigator.pop(
                              //                 context); // dont remove or else it won't redirect to launching page
                              //           }
                              //         }),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Text("Don't have an account ? "),
                                  TextButton(
                                      onPressed: () {
                                        DefaultTabController.of(context)!
                                            .animateTo(1);
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ))
                                ],
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
