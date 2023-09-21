import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preferences.g.dart';

@riverpod
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  // This should be overridden in main to await the instance before app launch
  throw UnimplementedError('No shared preferences provider');
}
