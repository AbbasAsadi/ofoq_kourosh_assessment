import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/api_service.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_event.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_bloc/home_state.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/repository/home_repository.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _homeRepository = locator();
  List<TaskModel> taskList = [];

  HomeBloc() : super(TaskLoadingState()) {
    on<FetchTaskListEvent>(_onFetchTasks);
    add(FetchTaskListEvent());
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onFetchTasks(
    FetchTaskListEvent event,
    Emitter<HomeState?> emit,
  ) async {
    String? userID = await locator<SecureStorage>().userID;
    if (userID == null) {
      emit(TaskErrorState(error: "کاربر یافت نشد", event));
      return;
    }

    await ApiService().callApi(
      _homeRepository.getUserTasks(userID),
      onLoading: () => emit(TaskLoadingState()),
      onSuccess: (response) {
        taskList = response.data ?? [];
        emit(TaskListLoadedSuccessfullyState(tasks: taskList));
      },
      onError: (error) => emit(TaskErrorState(error: error.toString(), event)),
    );
  }

  Future<void> _onDeleteTask(
    DeleteTaskEvent event,
    Emitter<HomeState> emit,
  ) async {
    await ApiService().callApi(
      _homeRepository.deleteTask(event.taskID),
      onLoading: () => emit(DeleteTaskLoadingState()),
      onSuccess: (response) {
        taskList.removeWhere((element) => element.id == event.taskID);
        emit(DeleteTaskSuccessfullyState());
        emit(TaskListLoadedSuccessfullyState(tasks: taskList));
      },
      onError: (error) => emit(TaskErrorState(error: error.toString(), event)),
    );
  }
}
