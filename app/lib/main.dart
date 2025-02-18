import 'package:flutter/material.dart';
import 'package:i18n/i18n.dart';
import 'package:i18n/i18next.dart';

import 'app_service_locator.dart';
import 'src/widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initAppDependencies();
  runApp(const RestaurantTourApp());
}

class RestaurantTourApp extends StatelessWidget {
  const RestaurantTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return I18nProvider.fromAssetBundle(
      i18nextOptions: I18NextOptions(
        formats: formatters,
        missingInterpolationHandler: interpolationFallback,
      ),
      child: const App(),
    );
  }
}
