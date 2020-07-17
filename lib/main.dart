import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/app/locator.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/router.gr.dart';
import 'app_viewmodel.dart';

void main() async {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppViewModel>.reactive(
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) => model.isBusy
            ? Center(
                child: Container(
                  child: CircularProgressIndicator(),
                ),
              )
            : MaterialApp(
                title: 'Flutter Demo',
                onGenerateRoute: Router().onGenerateRoute,
                navigatorKey: locator<NavigationService>().navigatorKey,
                supportedLocales: [
                  const Locale('en', 'US'), // English, no country code
                  const Locale('ar', 'EG'), // Arabic, no country code
                ],
                localizationsDelegates: [
                  // ... app-specific localization delegate[s] here

                  // custom localization delegate .. loads translations from json files
                  model.localOverrideDelegate,
                  // Built-in localization delegates
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback:
                    (locale, Iterable<Locale> supportedLocales) {
                  for (var supportedLocale in supportedLocales) {
                    if (supportedLocale.languageCode == locale.languageCode &&
                        supportedLocale.countryCode == locale.countryCode) {
                      return supportedLocale;
                    }
                  }

                  // if the device locale is not supported, use first (english)
                  return supportedLocales.first; // english
                },
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  // This makes the visual density adapt to the platform that you run
                  // the app on. For desktop platforms, the controls will be smaller and
                  // closer together (more dense) than on mobile platforms.
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                debugShowCheckedModeBanner: false,
              ),
        viewModelBuilder: () => AppViewModel());
  }
}
