import 'package:flutter/cupertino.dart';

///本地化，以便支持多语言
class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(context, FlutterBlocLocalizations);
  }

  String get appTitle => "Flutter todos";
}

class FlutterBlocLocalizationsDelegate extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  Future<FlutterBlocLocalizations> load(Locale locale) {
    return Future(() => FlutterBlocLocalizations());
  }

  @override
  bool shouldReload(LocalizationsDelegate<FlutterBlocLocalizations> old) {
    return false;
  }

  @override
  bool isSupported(Locale locale) {
    return locale.languageCode.toLowerCase().contains('en');
  }
}