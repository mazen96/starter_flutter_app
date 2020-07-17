import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

import '../app_localizations.dart';

@lazySingleton
class AppLanguageService with ReactiveServiceMixin {
  RxValue<Locale> _appLocale = RxValue<Locale>(initial: Locale('en', 'US'));
  RxValue<SpecificLocalizationDelegate> _localeOverrideDelegate =
      RxValue<SpecificLocalizationDelegate>();

  SpecificLocalizationDelegate get localOverrideDelegate =>
      _localeOverrideDelegate.value;

  Locale get appLocal => _appLocale.value;

  List<String> _supportedLanguages = ['en', 'ar'];
  List<String> get supportedLanguages => _supportedLanguages;
  String _currentLanguage;
  String get currentLanguage => _currentLanguage;

  Future<void> initializeLanguagePreferences() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('language_code') == null) {
      //TODO: read device settings to get device language
      _appLocale.value = Locale('en', "US");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }
    _appLocale.value = Locale(
        prefs.getString('language_code'), prefs.getString('countryCode'));
    _currentLanguage = prefs.getString('language_code');
    _localeOverrideDelegate.value =
        SpecificLocalizationDelegate(_appLocale.value);
  }

  AppLanguageService() {
    listenToReactiveValues([_localeOverrideDelegate]);
  }

  Future<void> changeLanguage(String language) async {
    Locale type = detectLocaleFromUserInput(language);
    print('@@@@@@@@ locale type $type');
    var prefs = await SharedPreferences.getInstance();
    if (_appLocale.value == type) {
      print('case 1');
      return;
    }
    if (type == Locale("ar", "EG")) {
      print('case AR');
      _appLocale.value = Locale("ar", "EG"); ////////////////////////////////
      await prefs.setString('language_code', 'ar');
      await prefs.setString('countryCode', 'EG');
    } else {
      print('case EN');
      _appLocale.value = Locale("en", "US");
      await prefs.setString('language_code', 'en');
      await prefs.setString('countryCode', 'US');
    }

    _localeOverrideDelegate.value =
        new SpecificLocalizationDelegate(_appLocale.value);
  }

  Locale detectLocaleFromUserInput(String language) {
    String localCode, countryCode;
    switch (language) {
      case "en":
        localCode = "en";
        countryCode = "US";
        break;
      case "ar":
        localCode = "ar";
        countryCode = "EG";
        break;
      default:
        localCode = "en";
        countryCode = "US";
        break;
    }

    return Locale(localCode, countryCode);
  }
}
