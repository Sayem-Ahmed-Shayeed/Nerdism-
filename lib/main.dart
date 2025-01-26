import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nerdism/course_content.dart';
import 'package:nerdism/nerdism.dart';
import 'package:nerdism/retake_data.dart';
import 'package:nerdism/select_sem_page.dart';
import 'package:nerdism/splash_screen.dart';
import 'course_content_adapter.dart';
import 'data_model.dart';

var kColorScheme = Colors.white;
void main() async {
  await Hive.initFlutter();
  //registering hive adapters
  Hive.registerAdapter(UserInfoAdapter());
  Hive.registerAdapter(CourseContentDetailsAdapter());
  Hive.registerAdapter(RetakeCoursesAdapter());

  // this box is only used for storing the userName and batches.
  var userInfoBox = await Hive.openBox<UserInfo>('UserBox');
  //all the boxes for the courseContentDetails
  var cse1101Box = await Hive.openBox<CourseContentDetails>('CSE-1101');
  var cse1102Box = await Hive.openBox<CourseContentDetails>('CSE-1102');
  var cse1151Box = await Hive.openBox<CourseContentDetails>('CSE-1151');
  var mat1151Box = await Hive.openBox<CourseContentDetails>('MAT-1151');
  var ged1131Box = await Hive.openBox<CourseContentDetails>('GED-1131');
  var cse1211Box = await Hive.openBox<CourseContentDetails>('CSE-1211');
  var cse1212Box = await Hive.openBox<CourseContentDetails>('CSE-1212');
  var mat1251Box = await Hive.openBox<CourseContentDetails>('MAT-1251');
  var ged1171Box = await Hive.openBox<CourseContentDetails>('GED-1171');
  var phy1272Box = await Hive.openBox<CourseContentDetails>('PHY-1272');
  var eee1221Box = await Hive.openBox<CourseContentDetails>('EEE-1221');
  var eee1222Box = await Hive.openBox<CourseContentDetails>('EEE-1222');
  var cse2111Box = await Hive.openBox<CourseContentDetails>('CSE-2111');
  var cse2112Box = await Hive.openBox<CourseContentDetails>('CSE-2112');
  var eee2121Box = await Hive.openBox<CourseContentDetails>('EEE-2121');
  var eee2122Box = await Hive.openBox<CourseContentDetails>('EEE-2122');
  var mat2151Box = await Hive.openBox<CourseContentDetails>('MAT-2151');
  var ged1261Box = await Hive.openBox<CourseContentDetails>('GED-1261');
  var cse2211Box = await Hive.openBox<CourseContentDetails>('CSE-2211');
  var cse2212Box = await Hive.openBox<CourseContentDetails>('CSE-2212');
  var mat2251Box = await Hive.openBox<CourseContentDetails>('MAT-2251');
  var cse2221Box = await Hive.openBox<CourseContentDetails>('CSE-2221');
  var cse2222Box = await Hive.openBox<CourseContentDetails>('CSE-2222');
  var ged4251Box = await Hive.openBox<CourseContentDetails>('GED-4251');
  var cse3111Box = await Hive.openBox<CourseContentDetails>('CSE-3111');
  var cse3112Box = await Hive.openBox<CourseContentDetails>('CSE-3112');
  var cse3121Box = await Hive.openBox<CourseContentDetails>('CSE-3121');
  var cse3113Box = await Hive.openBox<CourseContentDetails>('CSE-3113');
  var cse3114Box = await Hive.openBox<CourseContentDetails>('CSE-3114');
  var ged1291Box = await Hive.openBox<CourseContentDetails>('GED-1291');
  var cse3212Box = await Hive.openBox<CourseContentDetails>('CSE-3212');
  var cse3213Box = await Hive.openBox<CourseContentDetails>('CSE-3213');
  var cse3214Box = await Hive.openBox<CourseContentDetails>('CSE-3214');
  var cse3231Box = await Hive.openBox<CourseContentDetails>('CSE-3231');
  var cse3232Box = await Hive.openBox<CourseContentDetails>('CSE-3232');
  var cse3201Box = await Hive.openBox<CourseContentDetails>('CSE-3201');
  var cse3202Box = await Hive.openBox<CourseContentDetails>('CSE-3202');
  var cse4111Box = await Hive.openBox<CourseContentDetails>('CSE-4111');
  var cse4112Box = await Hive.openBox<CourseContentDetails>('CSE-4112');
  var cse4113Box = await Hive.openBox<CourseContentDetails>('CSE-4113');
  var cse4114Box = await Hive.openBox<CourseContentDetails>('CSE-4114');
  var cse4116Box = await Hive.openBox<CourseContentDetails>('CSE-4116');
  var cse4161Box = await Hive.openBox<CourseContentDetails>('CSE-4161');
  var cse4119Box = await Hive.openBox<CourseContentDetails>('CSE-4119');
  var cse4800Box = await Hive.openBox<CourseContentDetails>('CSE-4800');
  var cse4315Box = await Hive.openBox<CourseContentDetails>('CSE-4315');
  var cse4233Box = await Hive.openBox<CourseContentDetails>('CSE-4233');
  var cse4234Box = await Hive.openBox<CourseContentDetails>('CSE-4234');
  var cse4801Box = await Hive.openBox<CourseContentDetails>('CSE-4801');
  var retakeCourseBox = await Hive.openBox<RetakeCourses>('retakeCourse');

  runApp(const NerdApp());
}

class NerdApp extends StatelessWidget {
  const NerdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kColorScheme,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
