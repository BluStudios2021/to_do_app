// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_new.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskNewAdapter extends TypeAdapter<TaskNew> {
  @override
  final int typeId = 1;

  @override
  TaskNew read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskNew()
      ..checked = fields[0] as bool
      ..header = fields[1] as String
      ..body = fields[2] as String
      ..marked = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, TaskNew obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.checked)
      ..writeByte(1)
      ..write(obj.header)
      ..writeByte(2)
      ..write(obj.body)
      ..writeByte(3)
      ..write(obj.marked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is TaskNewAdapter && runtimeType == other.runtimeType && typeId == other.typeId;
}
