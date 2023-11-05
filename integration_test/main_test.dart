import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:open_transit_app/data/shared_preferences_provider.dart';
import 'package:open_transit_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('test location selector', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
        ],
        child: const MainApp(),
      ),
    );

    expect(find.text('Choose your location'), findsOneWidget);

    await tester.pumpAndSettle(const Duration(seconds: 3));
    final dropdownMenu = find.text('Location');
    expect(dropdownMenu, findsOneWidget);
    await tester.tap(dropdownMenu, warnIfMissed: false);
    await tester.pumpAndSettle();

    final munich = find.text('Munich');
    expect(munich, findsOneWidget);
    await tester.tap(munich);
    await tester.pumpAndSettle();

    final drawerButton = find.byIcon(Icons.menu);
    expect(drawerButton, findsOneWidget);
    await tester.tap(drawerButton);
    await tester.pumpAndSettle();

    expect(find.text('Munich'), findsOneWidget);
    expect(find.text('Change'), findsOneWidget);
  });
}
