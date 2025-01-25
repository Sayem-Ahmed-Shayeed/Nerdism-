// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_content_adapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseContentDetailsAdapter extends TypeAdapter<CourseContentDetails> {
  @override
  final int typeId = 2;

  @override
  CourseContentDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseContentDetails(
      path: fields[0] as String,
      type: fields[2] as String,
      renamedName: fields[3] as String,
    )..date = fields[1] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CourseContentDetails obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.renamedName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseContentDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
