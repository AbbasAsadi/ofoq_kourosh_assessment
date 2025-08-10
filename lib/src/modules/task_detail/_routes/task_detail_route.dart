import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/task_detail_page.dart';

class TaskDetailRoutes {
  static const _taskDetailPagePath = '/taskDetail';
  static RouteBase route = GoRoute(
    path: _taskDetailPagePath,
    name: _taskDetailPagePath,
    builder: (_, state) => TaskDetailPage(task: state.extra as TaskModel?),
  );

  static Future<bool?> toTaskDetailPage(BuildContext context,
      {TaskModel? task}) async {
    return await context.pushNamed(_taskDetailPagePath, extra: task);
  }
}
