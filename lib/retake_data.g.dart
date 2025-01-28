// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retake_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RetakeCoursesAdapter extends TypeAdapter<RetakeCourses> {
  @override
  final int typeId = 3;

  @override
  RetakeCourses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RetakeCourses(
      courseName: fields[0] as String,
      courseCode: fields[1] as String,
      credit: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RetakeCourses obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.courseName)
      ..writeByte(1)
      ..write(obj.courseCode)
      ..writeByte(2)
      ..write(obj.credit);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RetakeCoursesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
