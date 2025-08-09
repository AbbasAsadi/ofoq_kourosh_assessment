import 'package:dio/dio.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/dio_interceptors.dart';
import 'package:ofoq_kourosh_assessment/src/core/constants/api_constants.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_error.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';

import 'dio_method.dart';

class CoreApi {
  Dio _dio = Dio();

  /// Connection timeout
  static const Duration connectionTimeOut = Duration(minutes: 1);

  /// Response timeout
  static const Duration receiveTimeOut = Duration(minutes: 1);

  CoreApi() {
    /// Initialize basic options
    BaseOptions options = BaseOptions(
      baseUrl: ApiConstants.baseURL,
      connectTimeout: connectionTimeOut,
      receiveTimeout: receiveTimeOut,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      validateStatus: (status) => true,
    );

    /// initialize dio
    _dio = Dio(options);

    /// Add interceptor
    _dio.interceptors.add(DioInterceptors());
  }

  /// Request method
  Future<ApiResponseWrapper<List?>> call(
    String path, {
    required ApiMethod method,
    Map<String, dynamic>? queryParameters,
    body,
    Duration expireDuration = const Duration(seconds: 15),
    String? key,
    bool forceFetch = false,
  }) async {
    Response response = await _dio.request(
      path,
      data: body,
      queryParameters: queryParameters,
      options: Options(method: method.name),
    );

    if ((response.data?.error ?? false) is DioException) {
      switch (response.data.error.errorType) {
        case ApiErrorType.connectionTimeout:
          response.data.error = ApiError(
            null,
            'سرور به موقع پاسخ نداد',
            requestOptions: response.data.error.requestOptions,
            errorType: ApiErrorType.values[response.data.error.type.index],
          );
          break;
        case ApiErrorType.connectionError:
          response.data.error = ApiError(
            null,
            'دسترسی به اینترنت را بررسی کنید',
            requestOptions: response.data.error.requestOptions,
            errorType: ApiErrorType.values[response.data.error.type.index],
          );
          break;
      }
    }

    if (response.statusCode == 429 &&
        (response.data.error.message == null ||
            response.data.error.message == 'null')) {
      response.data.error = ApiError(
        null,
        'تعداد درخواست های شما بیش از حد مجاز است، لطفا لحظاتی دیگر تلاش کنید',
        requestOptions: response.data.error.requestOptions,
        errorType: ApiErrorType.values[response.data.error.type.index],
      );
    }
    return response.data;
  }
}
