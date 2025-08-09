import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/user_response.dart';

abstract class AuthRepository {
  Future<ApiResponseWrapper<UserResponse?>> login(LoginParams params);

  Future<ApiResponseWrapper<bool>> signup(SignupParams params);
}
