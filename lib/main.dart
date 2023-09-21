import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/core/logging.dart';
import 'src/core/providers.dart';
import 'src/core/router.dart';
import 'src/settings/settings_notifier.dart';
import 'src/transit_routes/routes_cubit.dart';
import 'src/transit_routes/routes_repository.dart';

Future<void> main() async {
  logger.d('Initializing Open Transit app');

  WidgetsFlutterBinding.ensureInitialized();

  // This holds up app loading, but neccessary not to flash color theme
  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    BlocProvider(
      create: (_) => TransitRoutesCubit(
        transitRoutesRepository: TransitRoutesRepository(),
      )..loadRoutes(),
      child: ProviderScope(
        overrides: [pSharedPreferences.overrideWithValue(sharedPreferences)],
        child: const MainApp(),
      ),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Open Transit (${kDebugMode ? 'Debug' : 'Dev'})',
      themeMode: ref.watch(pSettings).themeMode,
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
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
