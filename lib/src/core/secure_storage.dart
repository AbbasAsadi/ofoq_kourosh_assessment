import 'dart:async';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ofoq_kourosh_assessment/locator.dart';

import 'constants/secure_storage_keys.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = locator();

  String? _accessToken;
  String? _userID;


  Future<String?> get userID async {
    if (_userID != null) return _userID;
    return (_userID = await _storage.read(
      key: SecureStorageKeys.userIDKey,
    ));
  }

  Future<void> setUserID(String userID) async {
    _userID = userID;
    return await _storage.write(
      key: SecureStorageKeys.userIDKey,
      value: userID,
    );
  }

  Future<String?> get accessToken async {
    if (_accessToken != null) return _accessToken;
    return (_accessToken = await _storage.read(
      key: SecureStorageKeys.accessTokenKey,
    ));
  }

  Future<void> setAccessToken(String access) async {
    _accessToken = access;
    return await _storage.write(
      key: SecureStorageKeys.accessTokenKey,
      value: access,
    );
  }

  Future<void> logout() async {
    _accessToken = null;
    _userID = null;
    await _storage.deleteAll();
  }
}
