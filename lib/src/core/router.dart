import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../home/home_view.dart';
import '../layout/default_page_wrapper.dart';
import '../layout/home_layout.dart';
import '../settings/settings_view.dart';
import '../transit_routes/routes_view.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'rootNavigator',
);
final _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shellNavigator',
);

@Riverpod(keepAlive: true)
GoRouter router(RouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => RegularPageWrapper(
          body: child,
          goRouterState: state,
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DefaultPageWrapper(
              child: MainView(),
            ),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (context, state) => const DefaultPageWrapper(
                  child: SettingsView(),
                ),
              ),
              GoRoute(
                path: ':network_id',
                builder: (context, state) => const DefaultPageWrapper(
                  child: MainView(),
                ),
                routes: [
                  GoRoute(
                    path: 'routes',
                    builder: (context, state) => const DefaultPageWrapper(
                      child: RoutesView(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
