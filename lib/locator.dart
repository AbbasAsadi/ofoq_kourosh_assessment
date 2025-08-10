import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:ofoq_kourosh_assessment/src/core/api/core_api.dart';
import 'package:ofoq_kourosh_assessment/src/core/secure_storage.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_local_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_mock_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_remote_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/data_source/auth_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/repository/auth_repository.dart';
import 'package:ofoq_kourosh_assessment/src/modules/auth/_data/repository/auth_repository_impl.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_mock_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_remote_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/data_source/home_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/repository/home_repository.dart';
import 'package:ofoq_kourosh_assessment/src/modules/home/_data/repository/home_repository_impl.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_mock_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/data_source/task_detail_remote_data_source.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/repository/task_detail_repository.dart';
import 'package:ofoq_kourosh_assessment/src/modules/task_detail/_data/repository/task_detail_repository_impl.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<FlutterSecureStorage>(
    FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );
  locator.registerSingleton<SecureStorage>(SecureStorage());
  locator.registerLazySingleton<AuthLocalSource>(() => AuthLocalSource());
  locator.registerLazySingleton<CoreApi>(() => CoreApi());

  if (appFlavor == 'mock') {
    locator.registerLazySingleton<AuthSource>(() => AuthMockSource());
    locator.registerLazySingleton<HomeSource>(() => HomeMockSource());
    locator.registerLazySingleton<TaskDetailDataSource>(
      () => TaskDetailMockDataSource(),
    );
  } else {
    locator.registerLazySingleton<AuthSource>(() => AuthRemoteSource());
    locator.registerLazySingleton<HomeSource>(() => HomeRemoteSource());
    locator.registerLazySingleton<TaskDetailDataSource>(
      () => TaskDetailRemoteDateSource(),
    );
  }

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(source: locator<AuthSource>()),
  );

  locator.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(source: locator<HomeSource>()),
  );

  locator.registerLazySingleton<TaskDetailRepository>(
    () => TaskDetailRepositoryImpl(source: locator<TaskDetailDataSource>()),
  );
}
