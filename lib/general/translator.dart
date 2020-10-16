import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class AppTranslations extends ChangeNotifier{
  String locale;
    Map<dynamic, dynamic> _localisedValues;

  AppTranslations(String locale) {
    this.locale = locale;

    // this.load(locale);
  }

    AppTranslations of(BuildContext context) {
    return Localizations.of<AppTranslations>(context, AppTranslations);
  }

    Future<AppTranslations> load(String locale) async {
    AppTranslations appTranslations = AppTranslations(locale);
    String jsonContent =
    await rootBundle.loadString("assets/locale/localization_${locale}.json");
    _localisedValues = json.decode(jsonContent);

    return appTranslations;
  }

  get currentLanguage => locale;

  String text(String key) {
    if(_localisedValues!=null)
    return _localisedValues[key] ??key;
    else
      return key;
  }
}