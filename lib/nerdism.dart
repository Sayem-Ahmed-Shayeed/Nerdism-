import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nerdism/SemWiseCourse.dart';
import 'package:nerdism/course_content.dart';

import 'addSubjectPage.dart';
import 'data_model.dart';

var textColor = const Color(0xffBCCCDC);
var appBarColor = const Color(0xff3E5879);

class Nerdism extends StatefulWidget {
  const Nerdism({super.key});

  @override
  State<Nerdism> createState() => _NerdismState();
}

class _NerdismState extends State<Nerdism> {
  late Box<UserInfo> userInfoBox;
  String subjectName = '';
  int semester = 0;
  String name = '';
  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    userInfoBox = await Hive.openBox<UserInfo>('UserBox');
    setState(() {
      semester = userInfoBox.getAt(0)!.semester;
      name = userInfoBox.getAt(0)!.name;
    });
  }

  void addSubject() async {
    String enteredSubjectName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSubjectPage(),
      ),
    );
    setState(() {
      subjectName = enteredSubjectName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: Text(
          "Nerdism",
          style: TextStyle(
            color: textColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: addSubject,
            icon: Icon(
              Icons.add,
              color: textColor,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 30),
            child: Text(
              "Welcome Back!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              "$name.",
              style: TextStyle(
                fontSize: 20,
                color: textColor,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: Courses[semester]!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CourseContent(
                                  courseTitle:
                                      Courses[semester]![index].courseTitle);
                            },
                          ),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                        ),
                        child: ListTile(
                          title: Text(
                            Courses[semester]![index].courseTitle,
                            style: TextStyle(fontSize: 14, color: textColor),
                          ),
                          subtitle: Text(
                            Courses[semester]![index].courseCode,
                            style: TextStyle(fontSize: 10, color: textColor),
                            textAlign: TextAlign.start,
                          ),
                          trailing: Text(
                            "Credit: ${Courses[semester]![index].credit}",
                            style: TextStyle(color: textColor),
                            textAlign: TextAlign.end,
                          ),
                          leading: Text(
                            "${index + 1}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
