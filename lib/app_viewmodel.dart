import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'app/locator.dart';
import 'app_localizations.dart';
import 'services/language_service.dart';

class AppViewModel extends ReactiveViewModel {
  final _appLanguageService = locator<AppLanguageService>();
  Locale get appLocal => _appLanguageService.appLocal;

  SpecificLocalizationDelegate get localOverrideDelegate =>
      _appLanguageService.localOverrideDelegate;

  Future<void> initialise() async {
    setBusy(true);
    await _appLanguageService.initializeLanguagePreferences();
    setBusy(false);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_appLanguageService];
}
