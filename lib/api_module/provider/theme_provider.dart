import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ThemeMode.system;

  void setTheme(ThemeMode themeMode) {
    state = themeMode;
  }
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

class SelectedColorNotifier extends Notifier<Color> {
  @override
  Color build() => const Color(0xFFFFE302);

  void setColor(Color color) {
    state = color;
  }
}

final selectedColorProvider =
    NotifierProvider<SelectedColorNotifier, Color>(SelectedColorNotifier.new);