import 'package:stacked/stacked.dart';
import 'package:starter_app/services/language_service.dart';

import '../../../app/locator.dart';

class HomeViewModel extends ReactiveViewModel {
  final _appLanguageService = locator<AppLanguageService>();
  List<String> _languages;
  String _selectedLanguage;
  String get selectedLanguage => _selectedLanguage;
  List<String> get languages => _languages;

  void initialise() {
    setBusy(true);
    _languages = _appLanguageService.supportedLanguages;
    _selectedLanguage = _appLanguageService.currentLanguage;
    setBusy(false);
  }

  void selectLanguage(String language) async {
    _selectedLanguage = language;
    await _appLanguageService.changeLanguage(language);
  }

  String _title = 'Home View';
  String get title => _title;

  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _counter++;
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_appLanguageService];
}
