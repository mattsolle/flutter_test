import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:restaurant_tour/main.dart' as app;
import 'package:restaurant_tour/core/constants/app_strings.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final tempDir = await Directory.systemTemp.createTemp();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => tempDir.path,
    );
  });

  testWidgets('App loads and navigates to restaurant details', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.allRestaurants), findsOneWidget);

    final firstRestaurantItem = find.byKey(const Key('restaurant_item_0'));
    expect(firstRestaurantItem, findsOneWidget);

    await tester.tap(firstRestaurantItem);
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.overallRating), findsOneWidget);
  });
}
