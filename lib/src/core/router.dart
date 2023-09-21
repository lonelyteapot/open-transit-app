import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:open_transit_app/src/home/home_layout.dart';
import 'package:open_transit_app/src/home/home_view.dart';
import 'package:open_transit_app/src/transit_routes/routes_view.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'rootNavigator');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shellNavigator');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScaffold(body: child),
      routes: [
        GoRoute(
          path: '/',
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
);
