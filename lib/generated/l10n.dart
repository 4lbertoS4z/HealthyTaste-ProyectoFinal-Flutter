// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Ingredients:`
  String get ingredients {
    return Intl.message(
      'Ingredients:',
      name: 'ingredients',
      desc: '',
      args: [],
    );
  }

  /// `Elaboration:`
  String get elaboration {
    return Intl.message(
      'Elaboration:',
      name: 'elaboration',
      desc: '',
      args: [],
    );
  }

  /// `Allergies:`
  String get allergies {
    return Intl.message(
      'Allergies:',
      name: 'allergies',
      desc: '',
      args: [],
    );
  }

  /// `Video Detail:`
  String get videoDetail {
    return Intl.message(
      'Video Detail:',
      name: 'videoDetail',
      desc: '',
      args: [],
    );
  }

  /// `Dessert Dishes`
  String get dessertDishes {
    return Intl.message(
      'Dessert Dishes',
      name: 'dessertDishes',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `First Dishes`
  String get firstDishes {
    return Intl.message(
      'First Dishes',
      name: 'firstDishes',
      desc: '',
      args: [],
    );
  }

  /// `Second Dishes`
  String get secondDishes {
    return Intl.message(
      'Second Dishes',
      name: 'secondDishes',
      desc: '',
      args: [],
    );
  }

  /// `Kcal WebView`
  String get kcalWebViewTitle {
    return Intl.message(
      'Kcal WebView',
      name: 'kcalWebViewTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `First`
  String get first {
    return Intl.message(
      'First',
      name: 'first',
      desc: '',
      args: [],
    );
  }

  /// `Seconds`
  String get seconds {
    return Intl.message(
      'Seconds',
      name: 'seconds',
      desc: '',
      args: [],
    );
  }

  /// `Desserts`
  String get desserts {
    return Intl.message(
      'Desserts',
      name: 'desserts',
      desc: '',
      args: [],
    );
  }

  /// `Kcal`
  String get kcal {
    return Intl.message(
      'Kcal',
      name: 'kcal',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `daily nutrient percentage per person`
  String get nutrients {
    return Intl.message(
      'daily nutrient percentage per person',
      name: 'nutrients',
      desc: '',
      args: [],
    );
  }

  /// `%Calories`
  String get calories {
    return Intl.message(
      '%Calories',
      name: 'calories',
      desc: '',
      args: [],
    );
  }

  /// `%Protein`
  String get protein {
    return Intl.message(
      '%Protein',
      name: 'protein',
      desc: '',
      args: [],
    );
  }

  /// `%Fats`
  String get fats {
    return Intl.message(
      '%Fats',
      name: 'fats',
      desc: '',
      args: [],
    );
  }

  /// `%Sugar`
  String get sugar {
    return Intl.message(
      '%Sugar',
      name: 'sugar',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
