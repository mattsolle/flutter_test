import 'package:core/core.dart';
import 'package:core/core_service_locator.dart' as core;
import 'package:core/flutter_dotenv.dart';

Future<void> initAppDependencies() async {
  await _appServiceLocator();
  await core.initServiceLocator();
}

Future<void> _appServiceLocator() async {
  await dotenv.load(fileName: '../.env');
  await di.allReady();
}
