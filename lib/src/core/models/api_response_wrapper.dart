import 'package:ofoq_kourosh_assessment/src/core/models/api_error.dart';

import 'api_request_status.dart';

class ApiResponseWrapper<T> {
  ApiRequestStatus status;
  T? data;
  ApiError? error;
  Map? responseHeader;

  ApiResponseWrapper.notStarted() : status = ApiRequestStatus.notStarted;

  ApiResponseWrapper.loading() : status = ApiRequestStatus.loading;

  ApiResponseWrapper.success(this.data, {this.responseHeader})
    : status = ApiRequestStatus.success;

  ApiResponseWrapper.error(this.error) : status = ApiRequestStatus.error;

  ApiResponseWrapper.serverError() : status = ApiRequestStatus.serverError;

  ApiResponseWrapper.unauthorized() : status = ApiRequestStatus.unauthorized;

  ApiResponseWrapper({required this.status, this.error, required T? data}) {
    if (status == ApiRequestStatus.success && data != null) {
      this.data = data;
    }
  }

  @override
  String toString() {
    return 'Status : $status \n Message : ${error?.message} \n Data : $data';
  }
}
