import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'retake_data.g.dart'; // This generates the necessary code for Hive serialization

const uuid = Uuid();

@HiveType(typeId: 3)
class RetakeCourses {
  RetakeCourses({
    required this.courseName,
    required this.courseCode,
    required this.credit,
  });

  @HiveField(0)
  String courseName;

  @HiveField(1)
  String courseCode;

  @HiveField(2)
  double credit;
}
