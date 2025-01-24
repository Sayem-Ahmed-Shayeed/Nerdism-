import 'package:uuid/uuid.dart';

const uuid = Uuid();

class CourseDetails {
  CourseDetails({
    required this.courseTitle,
    required this.courseCode,
    required this.credit,
  });

  String courseTitle;
  String courseCode;
  double credit;
  String id = uuid.v4();
}
