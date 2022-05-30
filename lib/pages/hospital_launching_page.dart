import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'launching_page.dart';

class HospitalLaunchingPage extends StatefulWidget {
  const HospitalLaunchingPage({Key? key}) : super(key: key);

  @override
  State<HospitalLaunchingPage> createState() => _HospitalLaunchingPageState();
}

class _HospitalLaunchingPageState extends State<HospitalLaunchingPage> {
  bool loading = false;
  String selectedValue = "A+";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Select Blood Group",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //drop down button with all blood group
              DropdownButton<String>(
                value: selectedValue,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                  // color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      selectedValue = newValue;
                    });
                  }
                },
                items: <String>[
                  'A+',
                  'A-',
                  'B+',
                  'B-',
                  'AB+',
                  'AB-',
                  'O+',
                  'O-'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              // request button
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: loading
                    ? CircularProgressIndicator()
                    : RaisedButton(
                        child: Text('Request'),
                        onPressed: () {
                          setState(() {
                            loading = true;
                          });

                          http
                              .get(Uri.parse(
                                  'https://amw.pythonanywhere.com/hospitaltrigger?lat=$latitude&long=$longitude&bloodgroup=${selectedValue}'))
                              .then((response) {
                            print('Response status: ${response.statusCode}');
                            print('Response body: ${response.body}');
                            setState(() {
                              loading = false;
                            });
                            if (response.statusCode == 200) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Success'),
                                      content: Text('Request sent'),
                                      actions: [
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('Request not sent'),
                                      actions: [
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            }
                          });
                        },
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
