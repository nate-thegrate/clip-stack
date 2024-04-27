import 'package:clip_stack/home/home.dart';
import 'package:clip_stack/keyboard_shortcuts.dart';
import 'package:clip_stack/local_storage.dart';
import 'package:clip_stack/navigator.dart';
import 'package:clip_stack/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final asyncSetup = [
    loadFromLocalStorage(),
  ];

  HardwareKeyboard.instance.addHandler(shortcuts);

  await Future.wait(asyncSetup);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Editing()),
        ChangeNotifierProvider(create: (_) => AppTheme()),
      ],
      builder: (context, _) => MaterialApp(
        theme: context.watch<AppTheme>().data(context),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
        navigatorKey: navKey,
      ),
    );
  }
}
