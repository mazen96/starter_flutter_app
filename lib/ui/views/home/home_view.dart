import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/app_localizations.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => model.isBusy
          ? Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  DropdownButton<String>(
                    value: model.selectedLanguage,
                    icon: Icon(Icons.language),
                    iconSize: 24,
                    onChanged: (String languageValue) {
                      model.selectLanguage(languageValue);
                    },
                    items: model.languages
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toUpperCase()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              body: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Text(model.counter.toString()),
                    ),
                    Center(
                      child: Text(
                          Translations.of(context).translate('first_string')),
                    ),
                    Center(
                      child: Text(
                          Translations.of(context).translate('second_string')),
                    ),
                    Center(
                      child: Text('text with no translation'),
                    ),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: model.updateCounter,
                child: Icon(Icons.add),
              ),
            ),
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
