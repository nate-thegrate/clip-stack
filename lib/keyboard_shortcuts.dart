import 'package:clip_stack/navigator.dart';
import 'package:flutter/services.dart';

bool shortcuts(KeyEvent event) {
  if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.escape) {
    navigator.pop();
    return true;
  }
  return false;
}
