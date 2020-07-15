import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:starter_app/app_localizations.dart';
import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(model.counter.toString()),
              ),
              Center(
                child: Text(AppLocalizations.of(context).translate('first_string')),
              ),
              Center(
                child: Text(AppLocalizations.of(context).translate('second_string')),
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