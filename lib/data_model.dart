import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'data_model.g.dart'; // This generates the necessary code for Hive serialization

const uuid = Uuid();

@HiveType(typeId: 1)
class UserInfo {
  UserInfo({
    required this.name,
    required this.batch,
  });

  @HiveField(0)
  String name;

  @HiveField(1)
  int batch;

  @HiveField(2)
  String id = uuid.v4();
}
