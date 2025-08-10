import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/entity/task_params.dart';

class TaskDetailMockDataSource extends TaskDetailDataSource {
  @override
  Future<ApiResponseWrapper> createTask(TaskParams params) {
    // TODO: implement createTask
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseWrapper> editTask(TaskParams params) {
    // TODO: implement editTask
    throw UnimplementedError();
  }
}
