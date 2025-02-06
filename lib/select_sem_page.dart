import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:nerdism/allCourses.dart';
import 'package:nerdism/course_model.dart';
import 'package:nerdism/nerdism.dart';
import 'package:nerdism/retake_data.dart';
import 'package:nerdism/theme&colors/colors.dart';

import 'data_model.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  late Box<UserInfo> userInfoBox;
  late Box<RetakeCourses> retakeCoursesBox;
  bool isLoading = true;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    userInfoBox = await Hive.openBox<UserInfo>('UserBox');
    retakeCoursesBox = await Hive.openBox<RetakeCourses>('retakeCourse');
    setState(() {
      isLoading = false; // Mark initialization as complete
    });
  }

  String suffixText = "";
  String name = '';
  int batch = -1;
  UserInfo? enteredInfo;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Example course list

  // Map to track selected courses
  final Map<String, bool> selectedCourses = {};

  void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      enteredInfo = UserInfo(name: name, batch: batch);
      userInfoBox.put(enteredInfo!.id, enteredInfo!);

      setState(() {
        isNavigating = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isNavigating = false;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Nerdism()),
        );
      });
    }
  }

  void handleCheckboxChange(
      String course, String code, double credit, bool? isSelected) {
    if (isSelected == true) {
      // Add course to retakeCoursesBox
      final retakeCourse =
          RetakeCourses(courseName: course, courseCode: code, credit: credit);
      retakeCoursesBox.add(retakeCourse);
    } else {
      var key = retakeCoursesBox.keyAt(retakeCoursesBox.length - 1);
      retakeCoursesBox.delete(key);
    }

    setState(() {
      selectedCourses[course] = isSelected ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || isNavigating) {
      Future.delayed(
        const Duration(seconds: 2),
      );
      // Show a loading indicator while waiting for the box to initialize
      return Scaffold(
        body: Center(
          child: LottieBuilder.asset(
            'assets/Lottie/loader.json',
            height: 10,
            width: 10,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return (userInfoBox.isNotEmpty)
        ? const Nerdism()
        : Scaffold(
            backgroundColor: appBarColor,
            appBar: AppBar(
              scrolledUnderElevation: 0,
              centerTitle: true,
              title: Text(
                "Nerdism",
                style: TextStyle(
                  fontFamily: 'font2',
                  color: textColor,
                  letterSpacing: 3,
                ),
              ),
              backgroundColor: appBarColor,
            ),
            body: Column(
              children: [
                const Divider(),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        left: 30,
                        right: 30,
                        bottom: 40,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                              fontFamily: 'font6',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                                fontFamily: 'font6',
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              labelText: "Name",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                fontFamily: 'font4',
                                color: Colors.white,
                              ),
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
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:
                                    (MediaQuery.of(context).size.width - 60) /
                                            2 -
                                        10,
                                child: TextFormField(
                                  style: const TextStyle(
                                    fontFamily: 'font6',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLength: 2,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(
                                      fontFamily: 'font6',
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    labelText: "Which batch are you in?",
                                    labelStyle: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'font4',
                                      color: Colors.white,
                                    ),
                                    suffixText: suffixText,
                                    suffixStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: 'font6',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        value.isEmpty ||
                                        int.parse(value) <= 40 ||
                                        int.parse(value) > 65) {
                                      return "Please enter a valid\nbatch(41-65)";
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) {
                                    batch = int.parse(newValue!);
                                  },
                                  onChanged: (val) {
                                    int value = int.parse(val);
                                    if (value == 41 ||
                                        value == 51 ||
                                        value == 61) {
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
                                      style: TextStyle(
                                        fontFamily: 'font1',
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: submit,
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(
                                        fontFamily: 'font1',
                                        fontSize: 14,
                                        color: textColor,
                                        //fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: [
                              Text(
                                "Select Courses for Retake",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'font1',
                                ),
                              ),
                              const Divider(),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView.builder(
                              //shrinkWrap: true,
                              itemCount: allCourses.length,
                              itemBuilder: (context, index) {
                                final course = allCourses[index].courseTitle;
                                final code = allCourses[index].courseCode;
                                final credit = allCourses[index].credit;
                                return CheckboxListTile(
                                  checkColor: Colors.black,
                                  activeColor: const Color(0xffA47551),
                                  checkboxShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  title: Text(
                                    course,
                                    style: TextStyle(
                                      fontFamily: 'font1',
                                      color: textColor2,
                                      fontSize: 17,
                                      //fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  subtitle: Text(
                                    code,
                                    style: TextStyle(
                                      fontFamily: 'font4',
                                      fontSize: 14,
                                      color: textColor2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  value: selectedCourses[course] ?? false,
                                  onChanged: (isSelected) =>
                                      handleCheckboxChange(
                                          course, code, credit, isSelected),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
