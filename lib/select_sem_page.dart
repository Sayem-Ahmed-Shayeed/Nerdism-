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
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    userInfoBox = await Hive.openBox<UserInfo>('UserBox');
    setState(() {
      isLoading = false; // Mark initialization as complete
    });
  }

  String suffixText = "";
  String name = '';
  int batch = -1;
  UserInfo? enteredInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      enteredInfo = UserInfo(name: name, batch: batch);
      userInfoBox.put(enteredInfo!.id, enteredInfo!);
      setState(() {}); // Refresh the widget to reflect new data
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show a loading indicator while waiting for the box to initialize
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return (userInfoBox.isNotEmpty)
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
                            width:
                                (MediaQuery.of(context).size.width - 60) / 2 -
                                    10,
                            child: TextFormField(
                              maxLength: 2,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                labelText: "Which batch are you in?",
                                suffixText: suffixText,
                              ),
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    int.parse(value) <= 40 ||
                                    int.parse(value) > 65) {
                                  return "Please enter a valid batch(41-65)";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                batch = int.parse(newValue!);
                              },
                              onChanged: (val) {
                                int value = int.parse(val);
                                if (value == 41 || value == 51 || value == 61) {
                                  suffixText = 'st';
                                } else if (value == 42 ||
                                    value == 52 ||
                                    value == 62) {
                                  suffixText = 'nd';
                                } else if (value == 43 ||
                                    value == 53 ||
                                    value == 63) {
                                  suffixText = 'rd';
                                } else {
                                  suffixText = 'th';
                                }

                                setState(
                                    () {}); // Refresh the widget to show suffix
                              },
                            ),
                          ),
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
                                      batch = -1;
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
