import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_error.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';

class ApiService {
  Future<ApiResponseWrapper<T>> callApi<T>(
    Future<ApiResponseWrapper<T>> job, {
    ValueGetter? onLoading,
    ValueGetter? onUnauthenticated,
    ValueChanged<ApiResponseWrapper<T>>? onSuccess,
    ValueChanged<ApiError>? onError,
  }) async {
    if (onLoading != null) {
      onLoading();
    }
    var result = await job;
    switch (result.status) {
      case ApiRequestStatus.success:
        if (onSuccess != null) {
          onSuccess(result);
        }
      case ApiRequestStatus.unauthorized:
        if (onUnauthenticated != null) {
          onUnauthenticated();
          break;
        }
      case ApiRequestStatus.serverError:
      case ApiRequestStatus.error:
        if (onError != null && result.error != null) {
          onError(result.error!);
        }
      default:
        break;
    }

    return result;
  }
}
