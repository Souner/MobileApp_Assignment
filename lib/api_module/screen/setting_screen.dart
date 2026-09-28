import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/app_localizations.dart';
import '../provider/language_provider.dart';
import '../provider/theme_provider.dart';

final List<Color> colors = [
  Colors.yellow,
  Colors.orange,
  Colors.deepOrange,
  Colors.red,
  Colors.pink,
  Colors.lightBlue,
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.lightGreen,
  Colors.lime,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
];

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);
    final selectedColor = ref.watch(selectedColorProvider);
    final locale = ref.watch(languageNotifierProvider);
    final loc = AppLocalizations.of(context);
    final isDark = switch (themeMode) {
      ThemeMode.dark => true,
      ThemeMode.light => false,
      ThemeMode.system =>
        MediaQuery.platformBrightnessOf(context) == Brightness.dark,
    };

    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor,
        foregroundColor: isDark ? Colors.white : Colors.black87,
        title: Text(loc.settings),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SwitchListTile(
                  value: isDark,
                  onChanged: (value) {
                    ref.read(themeNotifierProvider.notifier).setTheme(
                      value ? ThemeMode.dark : ThemeMode.light,
                    );
                  },
                  title: Text(
                    loc.darkMode,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    isDark ? loc.darkModeOn : loc.darkModeOff,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Card(
                elevation: 0,
                color: Theme.of(context).colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                      child: Text(
                        loc.language,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Text(
                        loc.languageSubtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    RadioGroup<String>(
                      groupValue: locale.languageCode,
                      onChanged: (value) {
                        if (value != null) {
                          ref
                              .read(languageNotifierProvider.notifier)
                              .setLanguage(Locale(value));
                        }
                      },
                      child: Column(
                        children: [
                          RadioListTile<String>(
                            value: 'en',
                            title: Text(loc.english),
                          ),
                          RadioListTile<String>(
                            value: 'km',
                            title: Text(loc.khmer),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: _buildColorGridView(colors, ref, selectedColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorGridView(
    List<Color> item,
    WidgetRef ref,
    Color selectedColor,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: item.length,
      itemBuilder: (context, index) {
        final color = item[index];
        final isSelected = color == selectedColor;

        return InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            ref.read(selectedColorProvider.notifier).setColor(color);
          },
          child: SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                if (isSelected)
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}