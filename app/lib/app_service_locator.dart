import 'package:core/core.dart';
import 'package:core/core_service_locator.dart' as core;

Future<void> initAppDependencies() async {
  await core.initServiceLocator();
  await di.allReady();
}
