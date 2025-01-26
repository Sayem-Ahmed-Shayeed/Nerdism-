import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:nerdism/SemWiseCourse.dart';
import 'package:nerdism/course_content.dart';
import 'package:nerdism/retake_data.dart';
import 'package:nerdism/theme&colors/colors.dart';
import 'data_model.dart';

class Nerdism extends StatefulWidget {
  const Nerdism({super.key});

  @override
  State<Nerdism> createState() => _NerdismState();
}

class _NerdismState extends State<Nerdism> {
  late Box<UserInfo> userInfoBox;
  late Box<RetakeCourses> retakeCoursesBox;
  String subjectName = '';
  int batch = 0;
  String name = '';
  bool isLoading = true; // To manage loading state

  @override
  void initState() {
    super.initState();
    openBox();
  }

  Future<void> openBox() async {
    try {
      userInfoBox = await Hive.openBox<UserInfo>('UserBox');
      retakeCoursesBox = await Hive.openBox<RetakeCourses>('retakeCourse');
      //print(retakeCoursesBox.length);
      if (userInfoBox.isNotEmpty && userInfoBox.getAt(0) != null) {
        setState(() {
          batch = userInfoBox.getAt(0)!.batch;
          name = userInfoBox.getAt(0)!.name;
        });
      } else {
        setState(() {
          batch = 0; // Default batch
          name = 'Guest'; // Default name
        });
        //print("No user info found in Hive box.");
      }
    } catch (e) {
      //print("Error opening Hive box or accessing data: $e");
      setState(() {
        batch = 0; // Default semester on error
        name = 'Error'; // Default name on error
      });
    } finally {
      setState(() {
        isLoading = false; // Data loading completed
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: appBarColor,
        title: Column(
          children: [
            Text(
              "N e r d i s m",
              style: TextStyle(color: textColor, fontFamily: 'font2'),
            ),
            const Divider(),
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: LottieBuilder.asset(
                'assets/Lottie/loader.json',
                fit: BoxFit.cover,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: textColor2,
                      fontFamily: 'font3',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Batch: $batch",
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                      color: textColor2,
                      fontFamily: 'font2',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: (Courses[batch]?.length ?? 0) +
                        retakeCoursesBox.length, // Total courses
                    itemBuilder: (context, index) {
                      if (index < (Courses[batch]?.length ?? 0)) {
                        // Regular course
                        final course = Courses[batch]![index];
                        return buildCourseTile(
                          index + 1,
                          course.courseTitle,
                          course.courseCode,
                          course.credit,
                          false,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CourseContent(
                                    courseTitle: course.courseTitle,
                                    courseCode: course.courseCode,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else {
                        // Retake course here
                        final retakeIndex =
                            index - (Courses[batch]?.length ?? 0);
                        final retakeCourse =
                            retakeCoursesBox.getAt(retakeIndex)!;
                        return buildCourseTile(
                          index + 1,
                          retakeCourse.courseName,
                          retakeCourse.courseCode,
                          retakeCourse.credit,
                          true,
                          () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return CourseContent(
                                    courseTitle: retakeCourse.courseName,
                                    courseCode: retakeCourse.courseCode,
                                  );
                                },
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
    );
  }

  /// Helper method to build course tiles
  /// if this is retake then mark it with another color.
  Widget buildCourseTile(
    int index,
    String title,
    String code,
    double? credit,
    bool retake,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: containerColor,
            ),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: 'font6',
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                code,
                style: const TextStyle(
                  fontSize: 9,
                  color: Colors.white,
                  fontFamily: 'font6',
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.start,
              ),
              trailing: credit != null
                  ? Text(
                      "Credit: $credit",
                      style: TextStyle(
                        color: retake ? Colors.red : Colors.white,
                        fontSize: 10,
                        fontFamily: 'font6',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.end,
                    )
                  : null,
              leading: Text(
                "$index",
                style: const TextStyle(
                  fontFamily: 'font6',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
