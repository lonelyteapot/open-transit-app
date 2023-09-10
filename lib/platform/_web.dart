import 'dart:html';

String? getBaseHref() {
  final allBaseTags = document.getElementsByTagName('base');
  if (allBaseTags.isEmpty) {
    return null;
  }
  final href = (allBaseTags.first as Element).getAttribute('href');
  return href;
}
