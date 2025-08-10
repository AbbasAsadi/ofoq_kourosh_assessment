import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';

class TaskParams {
  int? id;
  String? taskName;
  String? taskDesc;
  bool? isDone;
  String? userId;
  String? lat;
  String? lng;

  TaskParams({
    this.id,
    this.taskName,
    this.taskDesc,
    this.isDone,
    this.userId,
    this.lat,
    this.lng,
  });

  factory TaskParams.fromTaskModel(TaskModel task) => TaskParams(
    id: task.id,
    lng: task.lng,
    lat: task.lat,
    userId: task.userId,
    taskDesc: task.taskDesc,
    taskName: task.taskName,
    isDone: null,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (id != null) map['id'] = id;
    map['TaskName'] = taskName;
    map['TaskDesc'] = taskDesc;
    map['IsDone'] = isDone;
    map['UserId'] = userId;
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}
