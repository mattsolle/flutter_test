import 'package:core/core.dart';
import 'package:core/core_service_locator.dart' as core;
import 'package:core/flutter_dotenv.dart';
import 'package:home/home_service_locator.dart' as home;

Future<void> initAppDependencies() async {
  await _appServiceLocator();
  await core.initServiceLocator();
  await home.initServiceLocator();
}

Future<void> _appServiceLocator() async {
  await dotenv.load(fileName: '.env');
  await di.allReady();
}
