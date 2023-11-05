// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html';

import 'package:open_transit_app/utils/web_utils/web_utils.dart';

@Deprecated('Use WebUtils.instance instead. This function is internal')
WebUtils? makeWebUtils() => const _WebUtilsImpl();

class _WebUtilsImpl extends WebUtils {
  const _WebUtilsImpl();

  @override
  String? findBaseHref() {
    final allBaseTags = document.getElementsByTagName('base');
    if (allBaseTags.isEmpty) {
      return null;
    }
    final href = (allBaseTags.first as Element).getAttribute('href');
    return href;
  }

  @override
  Uri? getBaseUrl() {
    final indexHref = findBaseHref();
    if (indexHref == null) {
      return null;
    }
    final currentUrl = Uri.base;
    return Uri(
      scheme: currentUrl.scheme,
      userInfo: currentUrl.userInfo,
      host: currentUrl.host,
      port: currentUrl.port,
      path: indexHref,
    );
  }
}
