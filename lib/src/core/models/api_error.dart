import 'package:dio/dio.dart';

/// The exception enumeration indicates what type of exception
/// has happened during requests.
enum ApiErrorType {
  /// Caused by a connection timeout.
  connectionTimeout,

  /// It occurs when url is sent timeout.
  sendTimeout,

  ///It occurs when receiving timeout.
  receiveTimeout,

  /// Caused by an incorrect certificate as configured by [ValidateCertificate].
  badCertificate,

  /// The [ApiError] was caused by an incorrect status code as configured by
  /// [ValidateStatus].
  badResponse,

  /// When the request is cancelled, dio will throw a error with this type.
  cancel,

  /// Caused for example by a `xhr.onError` or SocketExceptions.
  connectionError,

  /// Default error type, Some other [Error]. In this case, you can use the
  /// [ApiError.error] if it is not null.
  unknown,

  /// Caused for access token be null or refresh token expire
  unAuthorized,

  /// Caused for status response code be between 402 - 499
  remoteError,

  /// Caused for server error and status response code between 500 - 599
  serverError,
}

extension ApiErrorTypeExtension on ApiErrorType {
  String toPrettyDescription() {
    switch (this) {
      case ApiErrorType.connectionTimeout:
        return 'connection timeout';
      case ApiErrorType.sendTimeout:
        return 'send timeout';
      case ApiErrorType.receiveTimeout:
        return 'receive timeout';
      case ApiErrorType.badCertificate:
        return 'bad certificate';
      case ApiErrorType.badResponse:
        return 'bad response';
      case ApiErrorType.cancel:
        return 'request cancelled';
      case ApiErrorType.connectionError:
        return 'connection error';
      case ApiErrorType.unknown:
        return 'unknown';
      case ApiErrorType.unAuthorized:
        return 'unAuthorized';
      case ApiErrorType.remoteError:
        return 'remote error';
      case ApiErrorType.serverError:
        return 'server error';
    }
  }
}

class ApiError extends DioException {
  final int? code;
  final String errorMessage;
  final ApiErrorType errorType;

  ApiError(
    this.code,
    this.errorMessage, {
    required super.requestOptions,
    required this.errorType,
  });

  factory ApiError.fromDioException(DioException dioException) {
    return ApiError(
      null,
      dioException.message ?? 'error',
      requestOptions: dioException.requestOptions,
      errorType: ApiErrorType.values[dioException.type.index],
    );
  }

  @override
  String toString() {
    return 'ApiError [${errorType.toPrettyDescription()}]: $message with code: $code';
  }
}
