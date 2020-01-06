// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskModelAdapter extends TypeAdapter<TaskModel> {
  @override
  TaskModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskModel(
      idTask: fields[0] as String,
      titleTask: fields[1] as String,
      imageTask: fields[2] as String,
      dateCreate: fields[3] as DateTime,
      codeIcon: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TaskModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.idTask)
      ..writeByte(1)
      ..write(obj.titleTask)
      ..writeByte(2)
      ..write(obj.imageTask)
      ..writeByte(3)
      ..write(obj.dateCreate)
      ..writeByte(4)
      ..write(obj.codeIcon);
  }
}
