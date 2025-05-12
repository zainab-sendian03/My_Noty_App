import 'package:flutter/material.dart';

class ScreenSizeInheritedWidget extends InheritedWidget {
  final double screenWidth;
  final double screenHight;

  ScreenSizeInheritedWidget(
      {super.key,
      required super.child,
      required this.screenWidth,
      required this.screenHight});
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static ScreenSizeInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ScreenSizeInheritedWidget>();
  }
}
