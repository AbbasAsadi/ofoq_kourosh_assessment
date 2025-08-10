import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';

sealed class TaskDetailEvent {}

class CreateTaskEvent extends TaskDetailEvent {
  final TaskParams task;

  CreateTaskEvent({required this.task});
}

class EditTaskEvent extends TaskDetailEvent {
  final TaskParams task;

  EditTaskEvent({required this.task});
}
