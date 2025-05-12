import 'package:firebase_test/core/constants/screen_size_inherited_widget.dart';
import 'package:flutter/material.dart';

extension ScreenSize on BuildContext {
  double get screenWidth => ScreenSizeInheritedWidget.of(this)!.screenWidth;
  double get screenHeight => ScreenSizeInheritedWidget.of(this)!.screenHight;
}
