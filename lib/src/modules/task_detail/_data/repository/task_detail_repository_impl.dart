import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/repository/task_detail_repository.dart';

class TaskDetailRepositoryImpl extends TaskDetailRepository {
  final TaskDetailDataSource source;

  TaskDetailRepositoryImpl({required this.source});

  @override
  Future<ApiResponseWrapper<bool?>> createTask(TaskParams params) async {
    final response = await source.createTask(params);
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: response.status == ApiRequestStatus.success,
    );
  }

  @override
  Future<ApiResponseWrapper<bool?>> editTask(TaskParams params) async {
    final response = await source.editTask(params);
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: response.status == ApiRequestStatus.success,
    );
  }
}
