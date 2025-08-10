import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';

abstract class TaskDetailRepository {
  Future<ApiResponseWrapper<bool?>> createTask(TaskParams params);

  Future<ApiResponseWrapper<bool?>> editTask(TaskParams params);
}
