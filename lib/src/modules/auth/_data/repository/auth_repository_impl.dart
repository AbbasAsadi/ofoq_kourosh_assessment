import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_request_status.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/user_response.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthSource source;

  AuthRepositoryImpl({required this.source});

  @override
  Future<ApiResponseWrapper<UserResponse?>> login(LoginParams params) async {
    final response = await source.login(params);
    if (response.status == ApiRequestStatus.success &&
        ((response.data as List?)?.isNotEmpty ?? false)) {
      final data = UserResponse.fromJson(response.data[0]);

      /// save token and userID to {SecureStorage}
      locator<SecureStorage>().setAccessToken(data.token);
      locator<SecureStorage>().setUserID(data.id.toString());

      return ApiResponseWrapper.success(data);
    }
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: null,
    );
  }

  @override
  Future<ApiResponseWrapper<bool>> signup(SignupParams params) async {
    final response = await source.signup(params);
    return ApiResponseWrapper(
      status: response.status,
      error: response.error,
      data: response.status == ApiRequestStatus.success,
    );
  }
}
