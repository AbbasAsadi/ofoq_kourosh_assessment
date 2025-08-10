import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_bloc/task_detail_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/repository/task_detail_repository.dart';

class TaskDetailBloc extends Bloc<TaskDetailEvent, TaskDetailState> {
  final TaskDetailRepository _repository = locator();

  TaskDetailBloc(super.initialState) {
    on<CreateTaskEvent>(_onCreateTask);
    on<EditTaskEvent>(_onEditTask);
  }

  Future<void> _onCreateTask(
    CreateTaskEvent event,
    Emitter<TaskDetailState> emit,) async {
    emit(TaskLoadingState());

    final response = await _repository.createTask(event.task);
    if (response.status == ApiRequestStatus.success) {
      emit(TaskSuccessState());
    } else {
      emit(
        TaskFailureState(
          error: response.error?.message ?? 'ساخت تسک با شکست مواجه شد',
        ),
      );
    }
  }

  Future<void> _onEditTask(
    EditTaskEvent event,
    Emitter<TaskDetailState> emit,) async {
    emit(TaskLoadingState());

    final response = await _repository.editTask(event.task);
    if (response.status == ApiRequestStatus.success) {
      emit(TaskSuccessState());
    } else {
      emit(
        TaskFailureState(
          error: response.error?.message ?? 'ویرایش تسک با شکست مواجه شد',
        ),
      );
    }
  }
}
