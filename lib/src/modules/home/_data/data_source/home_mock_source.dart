import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_source.dart';

class HomeMockSource extends HomeSource {
  @override
  Future<ApiResponseWrapper> getUserTaskList(String userID) {
    // TODO: implement getUserTaskList
    throw UnimplementedError();
  }
}
