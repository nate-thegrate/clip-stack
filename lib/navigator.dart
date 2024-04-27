import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

Nav get navigator => Nav(navKey.currentState!);

extension type Nav(NavigatorState navigator) {
  Future<T?> push<T>(Widget destination) =>
      navigator.push<T>(MaterialPageRoute<T>(builder: (context) => destination));

  Future<void> pushReplacement(Widget destination) => navigator.pushReplacement<void, void>(
        MaterialPageRoute<void>(builder: (context) => destination),
      );

  void pop<T>([T? value]) => navigator.maybePop<T>(value);

  Future<T?> showDialog<T>({required WidgetBuilder builder, bool? barrierDismissible}) {
    return showAdaptiveDialog<T>(
      context: navigator.context,
      builder: builder,
      barrierDismissible: barrierDismissible,
    );
  }

  void showSnackBar(SnackBar snackBar) =>
      ScaffoldMessenger.of(navigator.context).showSnackBar(snackBar);
}
