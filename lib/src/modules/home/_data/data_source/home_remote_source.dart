import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/core_api.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/dio_method.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_source.dart';

class HomeRemoteSource extends HomeSource {
  final _api = locator<CoreApi>();

  @override
  Future<ApiResponseWrapper> getUserTaskList(String userID) {
    return _api.call<List>(
      'Task',
      method: ApiMethod.get,
      queryParameters: {"UserId": "eq.$userID"},
    );
  }

  @override
  Future<ApiResponseWrapper> deleteTask(int taskID) {
    return _api.call<String>(
      'Task',
      method: ApiMethod.delete,
      queryParameters: {"id": "eq.$taskID"},
    );
  }
}
