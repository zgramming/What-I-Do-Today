import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:network/models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final String taskBox = "task_box";

  Future<void> addTask({
    @required String keyTask,
    @required TaskModel taskModel,
  }) async {
    final hiveBox = Hive.box(taskBox);
    final hiveValue = taskModel;
    await hiveBox.put(keyTask, hiveValue);
    return notifyListeners();
  }

  void updateTask({String keyTask, TaskModel taskModel}) async {
    final hiveBox = Hive.box(taskBox);
    final hiveValue = taskModel;
    hiveBox.put(keyTask, hiveValue);
    notifyListeners();
  }

  void deleteTask({@required String keyTask}) async {
    final hiveBox = Hive.box(taskBox);
    await hiveBox.delete(keyTask);
    notifyListeners();
  }
}
