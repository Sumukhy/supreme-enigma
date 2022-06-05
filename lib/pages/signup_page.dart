import 'package:AMW/service/auth.dart';
import 'package:AMW/widget/custom_raised_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../widget/custom_dialog.dart';
import 'login_page.dart';

/// This is signup page
class SignUpPage extends StatefulWidget {
  final bool redirectFromSignInPage;
  const SignUpPage({Key? key, this.redirectFromSignInPage = false})
      : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool? agreedPrivacyTerms = false;
  bool agreedTandc = false;
  final _formKey = GlobalKey<FormState>();
  String category = 'user';

  bool _hidePasswordView1 = true;

  bool _hidePasswordView2 = true;

  // TextEditingController userEmailController = TextEditingController();

  final TextEditingController _password = TextEditingController(text: "");
  final TextEditingController _departmentID = TextEditingController(text: "");
  final TextEditingController _familyName = TextEditingController(text: "");
  final TextEditingController _familyEmail = TextEditingController(text: "");

  String? password;
  double? passwordStrength;
  String passwordStatus = "";
  Color passwordStatusColor = Colors.red;
  bool showPasswordStrength = false;

  final TextEditingController _confirmpassword =
      TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ? Colors.transparent : kbackgroundColor,
      body: ProgressHUD(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // category text
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Category",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // category selection - Police user hospital - radio button
                      // radio button for police
                      Row(
                        children: [
                          Radio(
                              value: "police",
                              groupValue: category,
                              onChanged: (value) {
                                setState(() {
                                  category = value as String;
                                });
                              }),
                          const Text("Police",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      // radio button for hospital
                      Row(
                        children: [
                          Radio(
                              value: "hospital",
                              groupValue: category,
                              onChanged: (value) {
                                setState(() {
                                  category = value as String;
                                });
                              }),
                          const Text("Hospital",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      // radio button for user
                      Row(
                        children: [
                          Radio(
                              value: "user",
                              groupValue: category,
                              onChanged: (value) {
                                setState(() {
                                  category = value as String;
                                });
                              }),
                          const Text("User",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              decoration: customInputDecoration(
                                  // fill:true
                                  "Email",
                                  const Opacity(
                                      opacity: 0,
                                      child: Icon(Icons.visibility)),
                                  const Icon(Icons.email)),
                              keyboardType: TextInputType.emailAddress,
                              controller: userEmailController,
                              validator: (val) {
                                RegExp regex = RegExp(kEmailPattern as String);
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
                          category == "user"
                              ? Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        decoration: customInputDecoration(
                                          "Family Member Name",
                                          SizedBox(),
                                          Icon(Icons.person),
                                        ),
                                        controller: _familyName,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Please enter family member name";
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
                                          "Family Email ID",
                                          SizedBox(),
                                          Icon(Icons.email),
                                        ),
                                        controller: _familyEmail,
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Please enter password to confirm";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    decoration: customInputDecoration(
                                      category == 'hospital'
                                          ? "Hospital ID"
                                          : "Department ID",
                                      SizedBox(),
                                      Icon(Icons.assured_workload_outlined),
                                    ),
                                    controller: _confirmpassword,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return category == 'hospital'
                                            ? "Please enter hospital ID"
                                            : "Please enter department ID";
                                      } else if (category == "hospital" &&
                                          ![
                                            "HOSPITAL1EW18CS140",
                                            "HOSPITAL1EW18CS141",
                                            "HOSPITAL1EW18CS142",
                                            "HOSPITAL1EW18CS143",
                                            "HOSPITAL1EW18CS144",
                                            "HOSPITAL1EW18CS145",
                                            "HOSPITAL1EW18CS146",
                                            "HOSPITAL1EW18CS147",
                                            "HOSPITAL1EW18CS148",
                                            "HOSPITAL1EW18CS149",
                                            "HOSPITAL1EW18CS150",
                                            "HOSPITAL1EW18CS171",
                                            "HOSPITAL1EW18CS172",
                                            "HOSPITAL1EW18CS173",
                                            "HOSPITAL1EW18CS174",
                                            "HOSPITAL1EW18CS175",
                                            "HOSPITAL1EW18CS176",
                                            "HOSPITAL1EW18CS177",
                                            "HOSPITAL1EW18CS178",
                                            "HOSPITAL1EW18CS179",
                                            "HOSPITAL1EW18CS180"
                                          ].contains(val.toUpperCase())) {
                                        return "Invalid Hospital ID";
                                      } else if (category == "police" &&
                                          ![
                                            "POLICE1EW18CS01",
                                            "POLICE1EW18CS02",
                                            "POLICE1EW18CS03",
                                            "POLICE1EW18CS04",
                                            "POLICE1EW18CS05",
                                            "POLICE1EW18CS06",
                                            "POLICE1EW18CS07",
                                            "POLICE1EW18CS08",
                                            "POLICE1EW18CS09",
                                            "POLICE1EW18CS10",
                                            "POLICE1EW18CS11",
                                            "POLICE1EW18CS12",
                                            "POLICE1EW18CS13",
                                            "POLICE1EW18CS14",
                                            "POLICE1EW18CS15",
                                            "POLICE1EW18CS16",
                                            "POLICE1EW18CS17",
                                            "POLICE1EW18CS18",
                                            "POLICE1EW18CS19",
                                            "POLICE1EW18CS20"
                                          ].contains(val.toUpperCase())) {
                                        return "Invalid Station ID";
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Focus(
                                  onFocusChange: (val) {
                                    setState(() {
                                      showPasswordStrength = val;
                                    });
                                  },
                                  child: TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    textInputAction: TextInputAction.next,
                                    decoration: customInputDecoration(
                                        "Password",
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              _hidePasswordView1 =
                                                  _hidePasswordView1
                                                      ? false
                                                      : true;
                                            });
                                          },
                                          child: Icon(_hidePasswordView1
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                        ),
                                        const Icon(Icons.lock)),
                                    obscureText: _hidePasswordView1,
                                    controller: _password,
                                    validator: (val) {
                                      // bool uppercase = false;
                                      // bool lowercase = false;
                                      // bool number = false;
                                      // bool specialChar = false;
                                      int score = 0;

                                      if (RegExp('[A-Z]').hasMatch(val!)) {
                                        // uppercase = true;
                                        score += 1;
                                      }
                                      if (RegExp('[a-z]').hasMatch(val)) {
                                        // lowercase = true;
                                        score += 1;
                                      }
                                      if (RegExp('[0-9]').hasMatch(val)) {
                                        // number = true;
                                        score += 1;
                                      }
                                      if (RegExp('[!@#%^&*()_+{}|:"<>?|;,.+]')
                                          .hasMatch(val)) {
                                        // specialChar = true;
                                        score += 1;
                                      }

                                      if (val.isEmpty) {
                                        return "Please enter password";
                                      } else if (val.length <= 7) {
                                        return "Your password should be more then 8 char long";
                                      } else if (score <= 1) {
                                        return "Password is Weak";
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      int score = 0;

                                      if (RegExp('[A-Z]').hasMatch(val)) {
                                        score += 1;
                                      }
                                      if (RegExp('[a-z]').hasMatch(val)) {
                                        score += 1;
                                      }
                                      if (RegExp('[0-9]').hasMatch(val)) {
                                        score += 1;
                                      }
                                      if (RegExp('[!@#%^&*()_+{}|:"<>?|;,.+]')
                                          .hasMatch(val)) {
                                        score += 1;
                                      }
                                      String status = "";
                                      Color temp = passwordStatusColor;

                                      if (score == 1) {
                                        status = ("Weak Password");
                                        temp = Colors.red;
                                      } else if (score == 2) {
                                        status = ("Good Password");
                                        temp = Colors.green;
                                      } else if (score == 3) {
                                        status = ("Strong Password");
                                        temp = Colors.green;
                                      } else if (score == 4) {
                                        status = ("Very Strong Password");
                                        temp = Colors.green;
                                      }
                                      print(score);
                                      if (status != "") {
                                        setState(() {
                                          passwordStatus = status;
                                          passwordStatusColor = temp;
                                        });
                                      }
                                      setState(() {
                                        password = val;
                                      });
                                    },
                                  ),
                                ),
                                Visibility(
                                  visible: showPasswordStrength,
                                  child: Text(
                                    passwordStatus,
                                    style:
                                        TextStyle(color: passwordStatusColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: customInputDecoration(
                                  "Confirm Password",
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _hidePasswordView2 =
                                            _hidePasswordView2 ? false : true;
                                      });
                                    },
                                    child: Icon(_hidePasswordView2
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                  ),
                                  const Icon(Icons.lock)),
                              obscureText: _hidePasswordView2,
                              controller: _confirmpassword,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Please enter password to confirm";
                                } else if (val != _password.text) {
                                  return "Your password is not matching";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      CustomRaisedButton(
                        buttonTitle: "Sign Up",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            print(userEmailController.text);
                            print(_password.text);
                            print(_confirmpassword.text);
                            final progress = ProgressHUD.of(context)!;
                            progress.showWithText('Signing Up...');
                            bool signUpSucess = await MyAuth().signUpWithEmail(
                                context,
                                userEmailController.text,
                                _password.text,
                                category,
                                _departmentID.text,
                                _familyName.text,
                                _familyEmail.text);

                            progress.dismiss();
                            if (signUpSucess) {
                              await showCustomDialog(context, "Success",
                                  "Your account has been successfully created.");

                              // if (widget.redirectFromSignInPage) {
                              //   Navigator.pop(context);
                              // } else {
                              //   Navigator.pop(context);
                              //   Get.to(() => LoginPage());
                              // }

                              // Get.to(() => LoginPage(
                              //     autofillEmail: userEmailController.text));
                              // userEmailController.text = "";
                              _password.text = "";
                              _confirmpassword.text = "";
                              _familyEmail.text = "";
                              _familyName.text = "";
                            }
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text("Already have an account ? "),
                          TextButton(
                              onPressed: () {
                                DefaultTabController.of(context)!.animateTo(0);
                              },
                              child: const Text(
                                "Sign In",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                          const Divider(
                            thickness: 2.5,
                            color: Colors.red,
                          ),
                        ],
                      ),
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

/// this custom decoration is for signin and signup page input fields.
InputDecoration customInputDecoration(
        String labelText, Widget suffix, Widget prefixIcon) =>
    InputDecoration(
      filled: true,
      fillColor: Colors.white,
      labelText: labelText,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(color: Colors.green, width: 1.5),
      ),
      prefixIcon: prefixIcon,
      suffix: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25.0),
        borderSide: const BorderSide(
          color: Colors.blue,
          width: 1.5,
        ),
      ),
    );
