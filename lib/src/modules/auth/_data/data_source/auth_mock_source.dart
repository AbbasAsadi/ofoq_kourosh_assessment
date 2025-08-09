import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';

class AuthMockSource extends AuthSource {
  @override
  Future<ApiResponseWrapper> login(LoginParams params) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<ApiResponseWrapper> signup(SignupParams params) {
    // TODO: implement signup
    throw UnimplementedError();
  }
}
