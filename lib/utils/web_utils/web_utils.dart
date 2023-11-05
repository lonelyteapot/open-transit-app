import 'package:open_transit_app/utils/web_utils/_stub_impl.dart' if (dart.library.html) '_web_impl.dart';

abstract class WebUtils {
  const WebUtils();

  // ignore: deprecated_member_use_from_same_package
  static final WebUtils? instance = makeWebUtils();

  String? findBaseHref();
  Uri? getBaseUrl();
}
