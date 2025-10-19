import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_local_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/datasources/auth_remote_data_source_real.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/check_secret_exists.dart';
import '../../features/auth/domain/usecases/get_secret.dart';
import '../../features/auth/domain/usecases/login_user.dart';
import '../../features/auth/domain/usecases/logout_user.dart';
import '../../features/auth/domain/usecases/recover_secret.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/bloc/recovery_bloc.dart';
import '../constants/app_constants.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // External dependencies
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // HTTP client for API calls
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceReal(
      httpClient: sl(),
      baseUrl: AppConstants.baseUrl,
    ),
  );
  sl.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(sharedPreferences: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => RecoverSecret(sl()));
  sl.registerLazySingleton(() => CheckSecretExists(sl()));
  sl.registerLazySingleton(() => GetSecret(sl()));
  sl.registerLazySingleton(() => LogoutUser(sl()));

  // BLoCs
  sl.registerFactory(
    () => AuthBloc(
      loginUser: sl(),
      checkSecretExists: sl(),
      getSecret: sl(),
      logoutUser: sl(),
    ),
  );
  sl.registerFactory(
    () => RecoveryBloc(
      recoverSecret: sl(),
    ),
  );
}
