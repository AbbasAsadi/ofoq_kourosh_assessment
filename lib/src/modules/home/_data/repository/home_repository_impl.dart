import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeSource source;

  HomeRepositoryImpl({required this.source});

  @override
  Future<ApiResponseWrapper<List<TaskModel>?>> getUserTasks(
    String userID,
  ) async {
    final response = await source.getUserTaskList(userID);
    if (response.status == ApiRequestStatus.success) {
      List<TaskModel> taskList = [];
      (response.data)?.forEach((v) {
        taskList.add(TaskModel.fromJson(v));
      });

      return ApiResponseWrapper.success(taskList);
    }
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: null,
    );
  }

  @override
  Future<ApiResponseWrapper<bool>> deleteTask(int taskID) async {
    final response = await source.deleteTask(taskID);
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: response.status == ApiRequestStatus.success,
    );
  }
}
