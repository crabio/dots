import 'package:dots_client/pages/main/page.dart';
import 'package:dots_client/pages/settings/page.dart';
import 'package:dots_client/settings/controller.dart';
import 'package:dots_client/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dots_client/main.dart';
import 'widget_test.mocks.dart';

@GenerateMocks([AppSettingsController])
void main() {
  testWidgets('Go to settings', (WidgetTester tester) async {
    final appSettingsController = MockAppSettingsController();
    // Stub a mock methods before interacting.
    when(appSettingsController.settings).thenReturn(AppSettings());

    // Build app
    await tester.pumpWidget(App(appSettingsController: appSettingsController));

    // Check that app on main page
    expect(find.byType(MainPage), findsOneWidget);

    // Tap settings btn
    await tester.tap(find.byKey(const Key("settings_btn")));
    await tester.pumpAndSettle();

    // Check that app on settings page
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}
