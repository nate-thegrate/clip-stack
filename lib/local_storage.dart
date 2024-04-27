import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadFromLocalStorage() async {
  _storage = await SharedPreferences.getInstance();
}

late final SharedPreferences _storage;

enum StorageKeys {
  themeMode,
  colorSeed,
  markdownEditing,
  ;

  dynamic get initial => switch (this) {
        themeMode => ThemeMode.system.index,
        colorSeed => const Color(0xff00eeff).value,
        markdownEditing => false,
      };

  dynamic get fromStorage => _storage.get(name) ?? initial;

  dynamic call() => switch (this) {
        themeMode => ThemeMode.values[fromStorage],
        colorSeed => Color(fromStorage),
        markdownEditing => fromStorage,
      };

  Future<bool> save(dynamic newValue) => switch (newValue) {
        // null => _storage.setString(name, 'null'),
        bool() => _storage.setBool(name, newValue),
        int() => _storage.setInt(name, newValue),
        double() => _storage.setDouble(name, newValue),
        String() => _storage.setString(name, newValue),
        List<String>() => _storage.setStringList(name, newValue),
        _ => throw TypeError(),
      };
}
