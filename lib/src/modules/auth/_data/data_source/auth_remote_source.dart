import 'package:ofoq_kourosh_assessment/src/core/api/core_api.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/dio_method.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_response_wrapper.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/login_params.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/entity/signup_params.dart';

class AuthRemoteSource extends AuthSource {
  final _api = CoreApi();

  @override
  Future<ApiResponseWrapper> login(LoginParams params) {
    return _api.call(
      'User',
      method: ApiMethod.get,
      queryParameters: params.toJson(),
    );
  }

  @override
  Future<ApiResponseWrapper> signup(SignupParams params) {
    return _api.call('User', method: ApiMethod.post, body: params.toJson());
  }
}
