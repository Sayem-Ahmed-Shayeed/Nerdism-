import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'course_content_adapter.g.dart';

var format = DateFormat.yMMMMd('en_US');

@HiveType(typeId: 2)
class CourseContentDetails {
  CourseContentDetails({
    required this.path,
    required this.type,
    required this.shortNote,
  });

  @HiveField(0)
  String path;

  @HiveField(1)
  DateTime date = DateTime.now();

  @HiveField(2)
  String type;

  @HiveField(3)
  String shortNote;
}
