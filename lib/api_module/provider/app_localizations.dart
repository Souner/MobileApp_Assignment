import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('km'),
  ];

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      'settings': 'Settings',
      'darkMode': 'Dark Mode',
      'darkModeOn': 'Currently in dark mode',
      'darkModeOff': 'Currently in light mode',
      'language': 'Language',
      'languageSubtitle': 'Choose app language',
      'english': 'English',
      'khmer': 'ខ្មែរ',
      'home': 'Home',
      'message': 'Message',
      'welcome': 'Welcome to My App!',
    },
    'km': {
      'settings': 'ការកំណត់',
      'darkMode': 'របៀបងងឹត',
      'darkModeOn': 'កំពុងប្រើរបៀបងងឹត',
      'darkModeOff': 'កំពុងប្រើរបៀបភ្លឺ',
      'language': 'ភាសា',
      'languageSubtitle': 'ជ្រើសរើសភាសាកម្មវិធី',
      'english': 'English',
      'khmer': 'ខ្មែរ',
      'home': 'ទំព័រដើម',
      'message': 'សារ',
      'welcome': 'សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់យើង!',
    },
  };

  String translate(String key) {
    return _strings[locale.languageCode]?[key] ?? _strings['en']![key] ?? key;
  }

  String get settings => translate('settings');
  String get darkMode => translate('darkMode');
  String get darkModeOn => translate('darkModeOn');
  String get darkModeOff => translate('darkModeOff');
  String get language => translate('language');
  String get languageSubtitle => translate('languageSubtitle');
  String get english => translate('english');
  String get khmer => translate('khmer');
  String get home => translate('home');
  String get message => translate('message');
  String get welcome => translate('welcome');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'km'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
