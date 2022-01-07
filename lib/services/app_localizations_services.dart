import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizationServices {
  late Locale locale;

  AppLocalizationServices(
      this.locale); //Helper method to keep the code in the widgets concise
  //Localizations are accessed using in InheritedWidget "of" syntax

  static AppLocalizationServices? of(BuildContext context) {
    return Localizations.of<AppLocalizationServices>(
        context, AppLocalizationServices);
  }

  //static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizationServices> delegate =
      _AppLocalizationsDelegate();

  Map<String, String>? _localizedStrings;

  Future<bool> load() async {
    //load the language JSON fill from the "lang" folder
    String jsonString =
        await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  //this method will be called from every widget which needs a localized text
  String? translate(String key) {
    return _localizedStrings![key];
  }
}

//LocalizationsDelegate is a factory for a set of localized resources
//In this case , the localized strings will e gotten in a AppLocalizationServices object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizationServices> {
  //This delegate instance will never change (it doesn't even have fields!)
  //It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // TODO: Include all of your supported language codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizationServices> load(Locale locale) async {
    // TODO:Applications class is where the JSON loading actually runs
    AppLocalizationServices localizationServices =
        AppLocalizationServices(locale);
    await localizationServices.load();
    return localizationServices;
  }

  @override
  bool shouldReload(
          covariant LocalizationsDelegate<AppLocalizationServices> old) =>
      false;
}
