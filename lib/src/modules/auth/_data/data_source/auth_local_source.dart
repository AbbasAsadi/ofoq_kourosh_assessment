import 'package:ofoq_kourosh_assessment/locator.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';

class AuthLocalSource {
  AuthLocalSource();

  Future<void> login(String access) async {
    await locator<SecureStorage>().setAccessToken(access);
  }

  Future logout() async {
    await locator<SecureStorage>().logout();
  }
}
