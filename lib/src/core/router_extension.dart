import 'package:go_router/go_router.dart';

extension GoRouterExtension on GoRouter {
  bool isIndexPage() {
    final matchedRoutes = routerDelegate.currentConfiguration.routes;
    if (matchedRoutes.length != 2) {
      return false;
    }
    if (matchedRoutes[1] case GoRoute route) {
      return route.path == '/';
    }
    return false;
  }

  bool isHomePage() {
    final matchedRoutes = routerDelegate.currentConfiguration.routes;
    if (matchedRoutes.length != 3) {
      return false;
    }
    if (matchedRoutes[2] case GoRoute route) {
      return route.path == ':network_id';
    }
    return false;
  }

  bool isSettingsPage() {
    final matchedRoutes = routerDelegate.currentConfiguration.routes;
    if (matchedRoutes.last case GoRoute route) {
      return route.path == 'settings';
    }
    return false;
  }
}
