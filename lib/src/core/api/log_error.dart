import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:ofoq_kourosh_assessment/src/core/models/api_error.dart';

class LogError {
  static void showInterceptorAPIError(ApiError error) {
    log('\n\n');
    log(
      '/*/*/*/*/*/*/*/*/*/*/*/* ${error.errorType.toPrettyDescription()} */*/*/*/*/*/*/*/*/*/*/*/',
    );
    log('ROOT: ${error.requestOptions.path}');
    log('MESSAGE: ${error.errorMessage}');
    log(
      '/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/*/',
    );
    log('\n\n');
  }

  static void print(String message) {
    debugPrint(
      '============================== $message at:${DateTime.now().millisecondsSinceEpoch} ===========================================',
    );
  }
}
