import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';

abstract class HomeSource {
  Future<ApiResponseWrapper> getUserTaskList(String userID);
}
