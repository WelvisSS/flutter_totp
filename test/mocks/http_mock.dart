import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';

// This will generate http_mock.mocks.dart
@GenerateMocks([http.Client])
void main() {}
