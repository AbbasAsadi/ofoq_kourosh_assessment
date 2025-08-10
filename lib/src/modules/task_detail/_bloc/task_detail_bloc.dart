import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_state.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  TaskDetailBloc(TaskDetailState initialState) : super(initialState) {
    on<CreateTasknitialEvent>(_onCreateTaskInitial);
    on<EditTaskInitialEvent>(_onEditTaskInitial);
  }

  Future<void> _onCreateTaskInitial(
    CreateTasknitialEvent event,
    Emitter<TaskDetailState> emit,
  ) async {}

  Future<void> _onEditTaskInitial(
    EditTaskInitialEvent event,
    Emitter<TaskDetailState> emit,
  ) async {}
}
