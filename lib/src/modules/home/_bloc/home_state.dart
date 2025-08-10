import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_event.dart';

sealed class HomeState {}

class TaskLoadingState extends HomeState {}

class TaskListLoadedSuccessfullyState extends HomeState {
  final List<TaskModel> tasks;

  TaskListLoadedSuccessfullyState({required this.tasks});
}

class TaskErrorState extends HomeState {
  final String error;
  final HomeEvent retryEvent;

  TaskErrorState(this.retryEvent, {required this.error});
}

class DeleteTaskLoadingState extends HomeState {}

class DeleteTaskSuccessfullyState extends HomeState {}
