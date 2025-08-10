import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/task_model.dart';

abstract class HomeRepository {
  Future<ApiResponseWrapper<List<TaskModel>?>> getUserTasks(String userID);

  Future<ApiResponseWrapper<bool>> deleteTask(int taskID);
}
