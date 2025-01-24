import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nerdism/nerdism.dart';

import 'data_model.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Box<UserInfo> userInfoBox;

  @override
  void initState() {
    openBox();
    super.initState();
  }

  Future<void> openBox() async {
    userInfoBox = await Hive.openBox<UserInfo>('UserBox');
    setState(() {});
  }

  String suffixText = "";
  String name = '';
  int semester = -1;
  UserInfo? enteredInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      enteredInfo = UserInfo(name: name, semester: semester);
      userInfoBox.put(enteredInfo!.id, enteredInfo!);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return (userInfoBox.length > 0)
        ? const Nerdism()
        : Scaffold(
            body: Center(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          labelText: "Name",
                          hintText: "Enter your name here...",
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length <= 2) {
                            return "Enter a valid name";
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          name = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2 - 20,
                            child: TextFormField(
                              maxLength: 1,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: "Which semester are you in?",
                                suffixText: suffixText,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) <= 0 ||
                                    int.parse(value) > 8) {
                                  return "Semester should be between 1 to 8.";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                semester = int.parse(newValue!);
                              },
                              onChanged: (val) {
                                int value = int.parse(val);
                                if (value == 1) {
                                  suffixText = 'st';
                                } else if (value == 2) {
                                  suffixText = 'nd';
                                } else if (value == 3) {
                                  suffixText = 'rd';
                                } else if (value == 4) {
                                  suffixText = 'th';
                                } else {
                                  suffixText = 'th';
                                }
                                setState(() {});
                              },
                            ),
                          ),
                          // const SizedBox(
                          //   width: 10,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState!
                                      .reset(); // Resets the form fields
                                  setState(
                                    () {
                                      name = "";
                                      semester = -1;
                                    },
                                  );
                                },
                                child: const Text(
                                  "Reset",
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: submit,
                                child: const Text("Submit"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
