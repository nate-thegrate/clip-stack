import 'package:clip_stack/local_storage.dart';
import 'package:clip_stack/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

bool _markdownEditing = StorageKeys.markdownEditing();
bool get markdownEditing => _markdownEditing;
set markdownEditing(bool newValue) {
  _markdownEditing = newValue;
  StorageKeys.markdownEditing.save(newValue);
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          CheckboxListTile.adaptive(
            value: markdownEditing,
            onChanged: (newVal) => setState(() => markdownEditing = newVal!),
            title: const Text('edit using Markdown?'),
          ),
          ListTile(
            title: const Text('brightness'),
            trailing: DropdownButton(
              value: context.watch<AppTheme>().mode,
              items: [
                for (final mode in ThemeMode.values)
                  DropdownMenuItem(
                    value: mode,
                    child: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Icon(switch (mode) {
                            ThemeMode.light => Icons.light_mode,
                            ThemeMode.dark => Icons.dark_mode,
                            ThemeMode.system => Icons.brightness_medium
                          }),
                          const SizedBox(width: 16),
                          Text(mode.name),
                        ],
                      ),
                    ),
                  )
              ],
              onChanged: (newMode) => context.read<AppTheme>().mode = newMode!,
            ),
          )
        ],
      ),
    );
  }
}
