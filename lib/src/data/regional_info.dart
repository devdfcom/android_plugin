import 'package:devdf_android/src/background_actions/bg_channel.dart';
import 'package:flutter/material.dart' show immutable;

/// Allows to get the regional information of the device.
///
/// Data like: locale, language, country, currency, date format, time format,
/// decimal & thousand separator, first day of the week and more.
@immutable
class RegionalInfo {
  /// Creates a new instance of [RegionalInfo].
  const RegionalInfo({
    required this.locale,
    required this.language,
    required this.country,
    required this.firstDayOfWeek,
    required this.timeFormat,
    required this.dateShort,
    required this.dateShortAlt,
    required this.dateMedium,
    required this.dateMediumAlt,
    required this.dateLong,
    required this.dateLongAlt,
    required this.decimalSeparator,
    required this.thousandSeparator,
    required this.currency,
    required this.currencySymbol,
    required this.currencySymbolPosition,
    required this.currencyFractionDigits,
    required this.metricMeasure,
  });

  ////////////////////////////////////////////////////////
  ///  Device locale, language, country
  /////////////////////////////////////////////////////////

  /// The locale of the device.
  /// language + "_" + country + "_" + (variant + "_#" | "#") + script + "_" + extensions
  final String locale;

  /// The language of the device.
  ///  ISO 639 language code (e.g. "en", "ro", "fr", "de", "es", "it", "pt", "ru", "zh", etc.)
  final String language;

  /// The country of the device.
  ///  ISO 3166 2-letter code, or a UN M.49 3-digit code. (e.g. "US", "RO", "591" etc.)
  ///  Null if locale has only language code (e.g. "en", "de").
  final String? country;

  ////////////////////////////////////////////////////////
  ///  Date & Time format, first day of the week
  /////////////////////////////////////////////////////////

  /// The first day of the week of the device.
  /// Starting from 1 (Sunday) to 7 (Saturday).
  final int firstDayOfWeek;

  /// The time format of the device.
  /// 0 = 12h, 1 = 24h
  final int timeFormat;

  /// Short date format of the device. (yyyy-MM-dd)
  final String dateShort;

  /// Alt Short date format of the device. (dd/MM/yy)
  final String dateShortAlt;

  /// Medium date format of the device. (d MMM yyyy)
  final String dateMedium;

  /// Alt Medium date format of the device. (d MMMM yyyy)
  final String dateMediumAlt;

  /// Long date format of the device. (EEE, d MMM yyyy)
  final String dateLong;

  /// Alt Long date format of the device. (EEEE, d MMMM yyyy)
  final String dateLongAlt;

  ////////////////////////////////////////////////////////
  ///  Currency format, numbers
  ///////////////////////////////////////////////////////

  /// The decimal separator of the device.
  final String decimalSeparator;

  /// The thousand separator of the device.
  final String thousandSeparator;

  /// The currency code of the device.
  /// ISO 4217 currency code (e.g. "USD", "EUR", "RON", "GBP", "JPY", etc.),
  /// null if locale has only language code (e.g. "en", "de").
  final String? currency;

  /// The currency symbol of the device.
  /// null if locale has only language code (e.g. "en", "de").
  final String? currencySymbol;

  /// The currency symbol position of the device.
  /// 0 = before, 1 = after
  /// null if locale has only language code (e.g. "en", "de").
  final int? currencySymbolPosition;

  /// The currency fraction digits.
  /// The number of digits after the decimal separator.
  /// null if locale has only language code (e.g. "en", "de").
  final int? currencyFractionDigits;

  /// Metric or imperial measure system.
  /// true = metric, false = imperial
  /// null if locale has only language code (e.g. "en", "de").
  final bool? metricMeasure;

  /// Gets regional information from the device or for specified locale
  /// Locale example: "en_US", "ro-RO", "fr"
  ///
  /// **WARNING:** If `locale` has only language code (e.g. "en"), it will not provide full information.
  static Future<RegionalInfo?> get({String? locale}) async =>
      BgChannel.instance.regionalInfo(locale: locale?.replaceAll('_', '-'));

  /// Factory constructor to create a new instance of [RegionalInfo] from a map.
  factory RegionalInfo.fromMap(Map<String, dynamic> map) => RegionalInfo(
        locale: map['locale'] as String,
        language: map['language'] as String,
        country: map['country'] as String?,
        firstDayOfWeek: map['firstDayOfWeek'] as int,
        timeFormat: map['timeFormat'] as int,
        dateShort: map['dateShort'] as String,
        dateShortAlt: map['dateShortAlt'] as String,
        dateMedium: map['dateMedium'] as String,
        dateMediumAlt: map['dateMediumAlt'] as String,
        dateLong: map['dateLong'] as String,
        dateLongAlt: map['dateLongAlt'] as String,
        decimalSeparator: map['decimalSeparator'] as String,
        thousandSeparator: map['thousandSeparator'] as String,
        currency: map['currency'] as String?,
        currencySymbol: map['currencySymbol'] as String?,
        currencySymbolPosition: map['currencySymbolPosition'] as int?,
        currencyFractionDigits: map['currencyFractionDigits'] as int?,
        metricMeasure: map['metricMeasure'] as bool?,
      );

  @override
  String toString() =>
      'RegionalInfo{locale: $locale, language: $language, country: $country, firstDayOfWeek: $firstDayOfWeek, timeFormat: $timeFormat, dateShort: $dateShort, dateShortAlt: $dateShortAlt, dateMedium: $dateMedium, dateMediumAlt: $dateMediumAlt, dateLong: $dateLong, dateLongAlt: $dateLongAlt, decimalSeparator: $decimalSeparator, thousandSeparator: $thousandSeparator, currency: $currency, currencySymbol: $currencySymbol, currencySymbolPosition: $currencySymbolPosition, currencyFractionDigits: $currencyFractionDigits, metricMeasure: $metricMeasure}';

  /// Converts the [RegionalInfo] instance to a map.
  Map<String, dynamic> toMap() => {
        'locale': locale,
        'language': language,
        'country': country,
        'firstDayOfWeek': firstDayOfWeek,
        'timeFormat': timeFormat,
        'dateShort': dateShort,
        'dateShortAlt': dateShortAlt,
        'dateMedium': dateMedium,
        'dateMediumAlt': dateMediumAlt,
        'dateLong': dateLong,
        'dateLongAlt': dateLongAlt,
        'decimalSeparator': decimalSeparator,
        'thousandSeparator': thousandSeparator,
        'currency': currency,
        'currencySymbol': currencySymbol,
        'currencySymbolPosition': currencySymbolPosition,
        'currencyFractionDigits': currencyFractionDigits,
        'metricMeasure': metricMeasure,
      };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegionalInfo &&
          runtimeType == other.runtimeType &&
          locale == other.locale &&
          language == other.language &&
          country == other.country &&
          firstDayOfWeek == other.firstDayOfWeek &&
          timeFormat == other.timeFormat &&
          dateShort == other.dateShort &&
          dateShortAlt == other.dateShortAlt &&
          dateMedium == other.dateMedium &&
          dateMediumAlt == other.dateMediumAlt &&
          dateLong == other.dateLong &&
          dateLongAlt == other.dateLongAlt &&
          decimalSeparator == other.decimalSeparator &&
          thousandSeparator == other.thousandSeparator &&
          currency == other.currency &&
          currencySymbol == other.currencySymbol &&
          currencySymbolPosition == other.currencySymbolPosition &&
          currencyFractionDigits == other.currencyFractionDigits &&
          metricMeasure == other.metricMeasure;

  @override
  int get hashCode => Object.hash(
        locale,
        language,
        country,
        firstDayOfWeek,
        timeFormat,
        dateShort,
        dateShortAlt,
        dateMedium,
        dateMediumAlt,
        dateLong,
        dateLongAlt,
        decimalSeparator,
        thousandSeparator,
        currency,
        currencySymbol,
        currencySymbolPosition,
        currencyFractionDigits,
        metricMeasure,
      );
}
