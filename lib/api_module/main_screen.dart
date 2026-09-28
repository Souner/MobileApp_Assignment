import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import 'provider/theme_provider.dart';
import 'screen/setting_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(selectedColorProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: const ColoredBox(color: Colors.blue),
          item: ItemConfig(icon: const Icon(Icons.home), title: 'Home'),
        ),
        PersistentTabConfig(
          screen: const ColoredBox(color: Color.fromARGB(255, 223, 255, 41)),
          item: ItemConfig(icon: const Icon(Icons.message), title: 'Message'),
        ),
        PersistentTabConfig(
          screen: const SettingsScreen(),
          item: ItemConfig(icon: const Icon(Icons.settings), title: 'Settings'),
        ),
      ],
      navBarBuilder: (navBarConfig) {
        return Style1BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: isDark
                ? selectedColor.withValues(alpha: 0.9)
                : selectedColor.withValues(alpha: 0.8),
          ),
        );
      },
    );
  }
}