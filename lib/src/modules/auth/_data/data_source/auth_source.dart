import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';

abstract class AuthSource {
  Future<ApiResponseWrapper> login(LoginParams params);

  Future<ApiResponseWrapper> signup(SignupParams params);
}
