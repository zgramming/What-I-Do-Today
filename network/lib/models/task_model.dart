import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType()
class TaskModel extends HiveObject {
  @HiveField(0)
  String idTask;
  @HiveField(1)
  String titleTask;
  @HiveField(2)
  String imageTask;
  @HiveField(3)
  DateTime dateCreate;
  @HiveField(4)
  int codeIcon;

  TaskModel({
    this.idTask,
    this.titleTask,
    this.imageTask,
    this.dateCreate,
    this.codeIcon,
  });
  factory TaskModel.fromJson(Map json) => TaskModel(
      idTask: json["idTask"],
      titleTask: json["titleTask"],
      imageTask: json["imageTask"],
      dateCreate: json["dateCreate"],
      codeIcon: json["codeIcon"]);
  // Hive fields go here
}
