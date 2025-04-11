import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_tour/app/ui/design_system/atoms/open_status_widget.dart';
import 'package:restaurant_tour/app/ui/utils/extensions/app_localization_extension.dart';
import 'package:restaurant_tour/app/ui/utils/extensions/context_extension.dart';

import '../../../test_widget.dart';

void main() {
  group('Widget Test - OpenStatusWidget', () {
    testWidgets(
        'Given the OpenStatusWidget component, \n'
        'When isOpen is true, \n'
        'Then it should display the "open now" text and the open status color indicator',
        (WidgetTester tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        TestWidget(
          builder: (ctx) {
            context = ctx;
            return const OpenStatusWidget(isOpen: true);
          },
        ),
      );

      expect(find.text(context.l10n.openNow), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);

      final Material material = tester.widget(find.byType(Material).last);
      expect(material.color, context.appColors.openStatusColor);
    });

    testWidgets(
        'Given the OpenStatusWidget component, \n'
        'When isOpen is false, \n'
        'Then it should display the "closed" text and the closed status color indicator',
        (WidgetTester tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        TestWidget(
          builder: (ctx) {
            context = ctx;
            return const OpenStatusWidget(isOpen: false);
          },
        ),
      );

      expect(find.text(context.l10n.closed), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);

      final Material material = tester.widget(find.byType(Material).last);
      expect(material.color, context.appColors.closedStatusColor);
    });
  });
}
