import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:nerdism/course_content.dart';
import 'package:nerdism/retake_data.dart';
import 'package:nerdism/select_sem_page.dart';
import 'package:nerdism/theme&colors/colors.dart';
import 'sem_wise_course.dart';
import 'course_content_adapter.dart';
import 'data_model.dart'; // Import FirstPage

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
  bool isChecking = true;
  bool isLoggingOut = false; //  to track logout process

  @override
  void initState() {
    super.initState();
    openBox().then((_) {
      setState(() {}); // Ensure UI updates after box initialization
    });
  }

  Future<void> openBox() async {
    try {
      userInfoBox = await Hive.openBox<UserInfo>('UserBox');
      retakeCoursesBox = await Hive.openBox<RetakeCourses>('retakeCourse');
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
      }
    } catch (e) {
      setState(() {
        batch = 0; // Default semester on error
        name = 'Error'; // Default name on error
      });
    } finally {
      setState(() {
        isLoading = false;
        isChecking = false;
      });
    }
  }

  Future<void> clearAllBoxes() async {
    await Future.wait([
      Hive.box<UserInfo>('UserBox').clear(),
      Hive.box<CourseContentDetails>('CSE-1101').clear(),
      Hive.box<CourseContentDetails>('CSE-1102').clear(),
      Hive.box<CourseContentDetails>('CSE-1151').clear(),
      Hive.box<CourseContentDetails>('MAT-1151').clear(),
      Hive.box<CourseContentDetails>('GED-1131').clear(),
      Hive.box<CourseContentDetails>('CSE-1211').clear(),
      Hive.box<CourseContentDetails>('CSE-1212').clear(),
      Hive.box<CourseContentDetails>('MAT-1251').clear(),
      Hive.box<CourseContentDetails>('GED-1171').clear(),
      Hive.box<CourseContentDetails>('PHY-1272').clear(),
      Hive.box<CourseContentDetails>('EEE-1221').clear(),
      Hive.box<CourseContentDetails>('EEE-1222').clear(),
      Hive.box<CourseContentDetails>('CSE-2111').clear(),
      Hive.box<CourseContentDetails>('CSE-2112').clear(),
      Hive.box<CourseContentDetails>('EEE-2121').clear(),
      Hive.box<CourseContentDetails>('EEE-2122').clear(),
      Hive.box<CourseContentDetails>('MAT-2151').clear(),
      Hive.box<CourseContentDetails>('GED-1261').clear(),
      Hive.box<CourseContentDetails>('CSE-2211').clear(),
      Hive.box<CourseContentDetails>('CSE-2212').clear(),
      Hive.box<CourseContentDetails>('MAT-2251').clear(),
      Hive.box<CourseContentDetails>('CSE-2221').clear(),
      Hive.box<CourseContentDetails>('CSE-2222').clear(),
      Hive.box<CourseContentDetails>('GED-4251').clear(),
      Hive.box<CourseContentDetails>('CSE-3111').clear(),
      Hive.box<CourseContentDetails>('CSE-3112').clear(),
      Hive.box<CourseContentDetails>('CSE-3121').clear(),
      Hive.box<CourseContentDetails>('CSE-3113').clear(),
      Hive.box<CourseContentDetails>('CSE-3114').clear(),
      Hive.box<CourseContentDetails>('GED-1291').clear(),
      Hive.box<CourseContentDetails>('CSE-3212').clear(),
      Hive.box<CourseContentDetails>('CSE-3213').clear(),
      Hive.box<CourseContentDetails>('CSE-3214').clear(),
      Hive.box<CourseContentDetails>('CSE-3231').clear(),
      Hive.box<CourseContentDetails>('CSE-3232').clear(),
      Hive.box<CourseContentDetails>('CSE-3201').clear(),
      Hive.box<CourseContentDetails>('CSE-3202').clear(),
      Hive.box<CourseContentDetails>('CSE-4111').clear(),
      Hive.box<CourseContentDetails>('CSE-4112').clear(),
      Hive.box<CourseContentDetails>('CSE-4113').clear(),
      Hive.box<CourseContentDetails>('CSE-4114').clear(),
      Hive.box<CourseContentDetails>('CSE-4116').clear(),
      Hive.box<CourseContentDetails>('CSE-4161').clear(),
      Hive.box<CourseContentDetails>('CSE-4119').clear(),
      Hive.box<CourseContentDetails>('CSE-4800').clear(),
      Hive.box<CourseContentDetails>('CSE-4315').clear(),
      Hive.box<CourseContentDetails>('CSE-4233').clear(),
      Hive.box<CourseContentDetails>('CSE-4234').clear(),
      Hive.box<CourseContentDetails>('CSE-4801').clear(),
      Hive.box<RetakeCourses>('retakeCourse').clear(),
    ]);
  }

  Future<void> logout() async {
    setState(() {
      isLoggingOut = true;
    });

    await Future.delayed(const Duration(seconds: 1)); // Simulating logout delay

    await clearAllBoxes(); // Ensure all data is cleared

    if (!mounted) return; // Check if the widget is still in the tree

    setState(() {
      isLoggingOut = false; // Hide loading spinner
    });

    // Navigate to FirstPage after logout
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FirstPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (isChecking)
        ? Center(
            child: LottieBuilder.asset(
              'assets/Lottie/loader.json',
              fit: BoxFit.cover,
              height: 20,
              width: 20,
            ),
          )
        : (userInfoBox.isEmpty)
            ? const FirstPage()
            : Scaffold(
                drawer: buildDrawer(),
                backgroundColor: appBarColor,
                appBar: AppBar(
                  centerTitle: true,
                  scrolledUnderElevation: 0,
                  backgroundColor: appBarColor,
                  title: Column(
                    children: [
                      Text(
                        "Nerdism",
                        style: TextStyle(
                            color: textColor2,
                            fontFamily: 'font2',
                            letterSpacing: 3),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
                body: isLoading
                    ? Center(
                        child: LottieBuilder.asset(
                          'assets/Lottie/loader.json',
                          height: 20,
                          width: 20,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                              top: 20,
                            ),
                            child: Text(
                              "Courses for $batch batch...",
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 15,
                                color: textColor,
                                fontFamily: 'font1',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              padding: const EdgeInsets.all(20),
                              itemCount: (courses[batch]?.length ?? 0) +
                                  retakeCoursesBox.length, // Total courses
                              itemBuilder: (context, index) {
                                if (index < (courses[batch]?.length ?? 0)) {
                                  final course = courses[batch]![index];
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
                                  final retakeIndex =
                                      index - (courses[batch]?.length ?? 0);
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
                                              courseTitle:
                                                  retakeCourse.courseName,
                                              courseCode:
                                                  retakeCourse.courseCode,
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

  Widget buildDrawer() {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: appBarColor),
            accountName: Text(
              name,
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.bold,
                fontFamily: 'font7',
              ),
            ),
            accountEmail: Text(
              "Batch: $batch",
              style: TextStyle(
                fontSize: 11,
                color: textColor2,
                //fontWeight: FontWeight.bold,
                fontFamily: 'font7',
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: containerColor,
              child: Icon(Icons.person, size: 40, color: appBarColor),
            ),
          ),
          ListTile(
              leading: const Icon(Icons.school),
              title: const Text("Courses Page"),
              onTap: () => Navigator.pop(context)),
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: Text(
              "Logout",
              style: TextStyle(
                  color: textColor2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'font6'),
            ),
            onTap: logout,
          ),
        ],
      ),
    );
  }

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
