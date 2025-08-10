import 'package:ofoq_kourosh_assessment/src/helper/extensions.dart';

class TaskModel {
  int? id;
  String? taskName;
  String? taskDesc;
  bool? isDone;
  String? userId;
  String? lat;
  String? lng;
  String? createdAt;

  TaskModel({
    this.createdAt,
    this.id,
    this.taskName,
    this.taskDesc,
    this.isDone,
    this.userId,
    this.lat,
    this.lng,
  });

  factory TaskModel.fromJson(dynamic json) => TaskModel(
    id: json['id'],
    taskName: json['TaskName'],
    taskDesc: json['TaskDesc'],
    isDone: json['IsDone'],
    userId: json['UserId'].toString(),
    lat: json['lat'],
    lng: json['lng'],
    createdAt: (json['created_at'] as String?)?.toJalaliDateTime,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['TaskName'] = taskName;
    map['TaskDesc'] = taskDesc;
    map['IsDone'] = isDone;
    map['UserId'] = userId;
    map['lat'] = lat;
    map['lng'] = lng;
    map['created_at'] = createdAt;
    return map;
  }
}
