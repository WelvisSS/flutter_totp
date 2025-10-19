import 'package:flutter_dev_test/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:flutter_dev_test/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mockito/annotations.dart';

// This will generate auth_datasources_mock.mocks.dart
@GenerateMocks([
  AuthRemoteDataSource,
  AuthLocalDataSource,
])
void main() {}
