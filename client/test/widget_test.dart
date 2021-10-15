// External
import 'package:dots_client/pages/main/form.dart';
import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Internal
import 'package:dots_client/main.dart';

void main() {
  testWidgets('Go to settings', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(App(settings: AppSettings()));

    // Check that app on main page
    expect(find.byType(MainPage), findsOneWidget);

    // Tap settings btn
    await tester.tap(find.byKey(const Key("settings_btn")));
    await tester.pumpAndSettle();

    // Check that app on settings page
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
