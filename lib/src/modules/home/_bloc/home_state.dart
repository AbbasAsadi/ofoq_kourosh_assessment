import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_event.dart';

sealed class HomeState {}

class TaskLoading extends HomeState {}

class TaskListLoadedSuccessfully extends HomeState {
  final List<TaskModel> tasks;

  TaskListLoadedSuccessfully({required this.tasks});
}

class TaskError extends HomeState {
  final String error;
  final HomeEvent retryEvent;

  TaskError(this.retryEvent, {required this.error});
}
