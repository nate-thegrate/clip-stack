import 'package:clip_stack/fonts.dart';
import 'package:clip_stack/local_storage.dart';
import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  ThemeMode _mode = StorageKeys.themeMode();
  ThemeMode get mode => _mode;
  set mode(ThemeMode newMode) {
    if (_mode == newMode) return;
    _mode = newMode;
    StorageKeys.themeMode.save(newMode.index);
    notifyListeners();
  }

  Color _seedColor = StorageKeys.colorSeed();
  Color get seedColor => _seedColor;
  set seedColor(Color newColor) {
    if (_seedColor == newColor) return;
    _seedColor = newColor;
    StorageKeys.colorSeed.save(newColor.value);
    notifyListeners();
  }

  ThemeData data(BuildContext context) {
    final brightness = switch (_mode) {
      ThemeMode.light => Brightness.light,
      ThemeMode.dark => Brightness.dark,
      ThemeMode.system => MediaQuery.platformBrightnessOf(context),
    };
    final colors = ColorScheme.fromSeed(seedColor: _seedColor, brightness: brightness);

    return ThemeData(
      colorScheme: colors,
      textTheme: TextTheme(
        headlineLarge: Pretendard(weight: 300, color: colors.onBackground),
        headlineMedium: Pretendard(weight: 333, color: colors.onBackground),
        headlineSmall: Pretendard(weight: 375, color: colors.onBackground),
        titleLarge: Pretendard(weight: 425, color: colors.onBackground.withAlpha(0xee)),
        titleMedium: Pretendard(weight: 500, color: colors.onBackground.withAlpha(0xe0)),
        titleSmall: Pretendard(weight: 600, color: colors.onBackground.withAlpha(0xc0)),
      ),
      fontFamily: 'pretendard',
    );
  }
}
