import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:starter_app/app/locator.dart';
import 'package:starter_app/app_localizations.dart';
import 'package:starter_app/ui/views/home/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'app/router.gr.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: Router().onGenerateRoute,
      initialRoute: Routes.startupView,
      navigatorKey: locator<NavigationService>().navigatorKey,
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('ar', 'EG'), // Arabic, no country code
      ],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here

        // custom localization delegate .. loads translations from json files
        AppLocalizations.delegate,
        // Built-in localization delegates
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, Iterable<Locale> supportedLocales){
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode){
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
      home: HomeView(),
    );
  }
}