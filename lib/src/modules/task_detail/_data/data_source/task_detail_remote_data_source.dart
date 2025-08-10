import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/core_api.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/dio_method.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';

class TaskDetailRemoteDateSource extends TaskDetailDataSource {
  final _api = locator<CoreApi>();

  @override
  Future<ApiResponseWrapper> createTask(TaskParams params) {
    return _api.call<String>(
      'Task',
      method: ApiMethod.post,
      body: params.toJson(),
    );
  }

  @override
  Future<ApiResponseWrapper> editTask(TaskParams params) {
    return _api.call<String>(
      'Task',
      method: ApiMethod.put,
      body: params.toJson(),
      queryParameters: {"id": "eq.${params.id}"},
    );
  }
}
