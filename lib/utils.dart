import 'package:flutter/material.dart';
import 'package:open_transit_app/platform/shared.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark {
    return brightness == Brightness.dark;
  }
}

Uri? getBaseUrl() {
  final baseHref = getBaseHref();
  if (baseHref == null) {
    return null;
  }
  return Uri(
    scheme: Uri.base.scheme,
    userInfo: Uri.base.userInfo,
    host: Uri.base.host,
    port: Uri.base.port,
    path: baseHref,
  );
}
