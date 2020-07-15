
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // helper method to keep the code in the widgets concise
  // localizations are accessed using an Inherited widget 'of' syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // static member to have a simple access to the delegate from the Material App
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocaliztionsDelegate();

  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    // load the language JSON file from the 'lang' folder
    // this is done through 'rootBundle'
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }


  // this function is used inside widgets to translate strings
  String translate(String key){
    return _localizedStrings[key];
  }
}

// localizationsDelegate is a factory for a set of localized resources
// in this case, the localized strings will be gotten in an AppLocalizations object

class _AppLocaliztionsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // this delegate instance will never change
  // so we provide a constant constructor
  const _AppLocaliztionsDelegate();

  @override
  bool isSupported(Locale locale) {
    // include all the supported languages codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocaliztionsDelegate old) => false;
}