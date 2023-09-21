import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final pSharedPreferences = Provider<SharedPreferences>((ref) {
  // This should be overridden in main to await the instance before app launch
  throw UnimplementedError('No shared preferences provider');
});
