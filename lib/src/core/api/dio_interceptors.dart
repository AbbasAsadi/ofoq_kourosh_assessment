import 'package:dio/dio.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/log_error.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_error.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';

class DioInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Add token to header
    final token = await locator<SecureStorage>().accessToken;
    if (token != null) {
      options.headers["Authorization"] = token;
    }
    options.headers["apikey"] = ApiConstants.apiKey;
    options.headers["Content-Type"] = "application/json";
    options.headers["Accept"] = "*/*";

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    if (hasServerError(response.statusCode)) {
      response.data = ApiResponseWrapper<Map<String, dynamic>?>.serverError;
    } else {
      if (isOk(response.statusCode)) {
        if (response.data is List<dynamic>?) {
          response.data = ApiResponseWrapper<List<dynamic>?>.success(
            response.data,
          responseHeader: response.headers.map,
        );
        } else {
          response.data = ApiResponseWrapper<String?>.success(
            response.data,
            responseHeader: response.headers.map,
          );
        }
      } else if (response.statusCode == 401) {
        await locator<SecureStorage>().logout();
        response.data = ApiResponseWrapper.unauthorized();
      } else if (hasError(response.statusCode)) {
        response.data = ApiResponseWrapper<Map<String, dynamic>?>.error(
          ApiError(
            response.statusCode,
            response.data['message'] ?? 'unknown error',
            requestOptions: response.requestOptions,
            errorType: ApiErrorType.remoteError,
          ),
        );
      }
      if ((response.data as ApiResponseWrapper).error != null) {
        LogError.showInterceptorAPIError(response.data.error!);
      }
    }
    handler.next(response);
  }

  bool isOk(int? statusCode) {
    return (((statusCode ?? 0) >= 200) && (statusCode ?? 0) < 300);
  }

  bool hasError(int? statusCode) {
    return (((statusCode ?? 0) >= 400) && (statusCode ?? 0) < 500);
  }

  bool hasServerError(int? statusCode) {
    return (((statusCode ?? 0) >= 500) && (statusCode ?? 0) < 600);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    Response response = Response(requestOptions: err.requestOptions);
    response.data = ApiResponseWrapper<Map<String, dynamic>?>.error(
      ApiError.fromDioException(err),
    );
    LogError.showInterceptorAPIError(response.data.error!);
    handler.resolve(response);
  }
}
