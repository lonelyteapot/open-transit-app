import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_transit_app/features/home_page/home_page.dart';
import 'package:open_transit_app/features/routes/routes_view.dart';
import 'package:open_transit_app/features/settings/settings_page.dart';
import 'package:open_transit_app/layout/main_page_wrapper.dart';
import 'package:open_transit_app/layout/main_shell.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
        builder: (context, state, child) => MainShell(
          body: child,
          goRouterState: state,
        ),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const MainPageWrapper(
              child: HomePage(),
            ),
            routes: [
              GoRoute(
                path: 'settings',
                builder: (context, state) => const MainPageWrapper(
                  child: SettingsPage(),
                ),
              ),
              GoRoute(
                path: ':network_id',
                builder: (context, state) => const MainPageWrapper(
                  child: HomePage(),
                ),
                routes: [
                  GoRoute(
                    path: 'routes',
                    builder: (context, state) => const MainPageWrapper(
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
