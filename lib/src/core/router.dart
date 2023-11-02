import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../home/home_view.dart';
import '../layout/home_layout.dart';
import '../settings/settings_view.dart';
import '../transit_routes/routes_view.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigator');

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) => RegularPageWrapper(
        body: child,
        goRouterState: state,
      ),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const MainView(),
          routes: [
            GoRoute(
              path: 'settings',
              builder: (context, state) => const SettingsView(),
            ),
            GoRoute(
              path: ':network_id',
              builder: (context, state) => const MainView(),
              routes: [
                GoRoute(
                  path: 'routes',
                  builder: (context, state) => const RoutesView(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
