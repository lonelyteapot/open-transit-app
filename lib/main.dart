import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_transit_app/data/constants.dart';
import 'package:open_transit_app/data/shared_preferences_provider.dart';
import 'package:open_transit_app/features/settings/settings_provider.dart';
import 'package:open_transit_app/routing/router.dart';
import 'package:open_transit_app/utils/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  logger.d('Initializing $kAppNameBase app');

  WidgetsFlutterBinding.ensureInitialized();

  // This holds up app loading, but neccessary not to flash color theme
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: '$kAppNameBase ($kAppBuildFlavor)',
      themeMode: ref.watch(settingsProvider).themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF25A18E),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF25A18E),
          brightness: Brightness.dark,
          background: const Color(0xFF1A1A1A),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
