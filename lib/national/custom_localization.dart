import 'dart:async';

import 'package:base_library/base_library.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

///国际化配置

/// localizedSimpleValues exapmle.
/// Map<String, Map<String, String>> _localizedSimpleValues = {
///   'en': {
///     'ok': 'OK',
///   },
///   'zh': {
///     'ok': '确定',
///   },
/// };
/// languageCode,id,value
Map<String, Map<String, String>> _localizedSimpleValues = {};

/// localizedValues exapmle.
/// Map<String, Map<String, Map<String, String>>> _localizedValues = {
///   'en': {
///     'US': {
///       'ok': 'OK',
///     }
///   },
///   'zh': {
///     'CN': {
///       'ok': '确定',
///     },
///     'HK': {
///       'ok': '確定',
///     },
///     'TW': {
///       'ok': '確定',
///     }
///   }
/// };
/// languageCode,countryCode,id,value
Map<String, Map<String, Map<String, String>>> _localizedValues = {};

///设置简体多语言资源
void setLocalizedSimpleValues(Map<String, Map<String, String>> localizedValues) {
  _localizedSimpleValues = localizedValues;
}

///设置多语言资源
void setLocalizedValues(Map<String, Map<String, Map<String, String>>> localizedValues) {
  _localizedValues = localizedValues;
}

/// 自定义本地化支持
class CustomLocalizations {
  Locale locale;

  CustomLocalizations(this.locale);

  static CustomLocalizations of(BuildContext context) =>
      Localizations.of<CustomLocalizations>(context, CustomLocalizations);

  /// get string by id,Can be specified languageCode,countryCode.
  /// 通过id获取字符串,可指定languageCode,countryCode.
  String getString(String id, {String languageCode, String countryCode, List<Object> params}) {
    String value;
    String _languageCode = languageCode ?? locale.languageCode;
    if (_localizedSimpleValues.isNotEmpty) {
      value = _localizedSimpleValues[_languageCode][id];
    } else {
      String _countryCode = countryCode ?? locale.countryCode;
      //若找不到对应国家code，默认为简体中文
      if (_countryCode == null ||
          _countryCode.isEmpty ||
          !_localizedValues[_languageCode].keys.contains(_countryCode)) {
        _countryCode = _localizedValues[_languageCode].keys.toList()[0];
      }
      value = _localizedValues[_languageCode][_countryCode][id];
    }
    if (ObjectUtil.isNotEmpty(params)) {
      for (int i = 0, length = params.length; i < length; i++) {
        value = value?.replaceAll('%\$$i\$s', '${params[i]}');
      }
    }
    return value;
  }

  /// supported Locales
  /// 支持的语言
  static Iterable<Locale> supportedLocales = _getSupportedLocales();

  static List<Locale> _getSupportedLocales() {
    List<Locale> list = List();
    if (_localizedSimpleValues.isNotEmpty) {
      _localizedSimpleValues.keys.forEach((languageCode) {
        list.add(Locale(languageCode, ''));
      });
    } else {
      _localizedValues.keys.forEach((languageCode) {
        _localizedValues[languageCode].keys.forEach((countryCode) {
          list.add(Locale(languageCode, countryCode));
        });
      });
    }
    return list;
  }

  static const LocalizationsDelegate<CustomLocalizations> delegate = _CustomLocalizationDelegate();
}

///自定义国际化代理
class _CustomLocalizationDelegate extends LocalizationsDelegate<CustomLocalizations> {
  const _CustomLocalizationDelegate();

  @override
  bool isSupported(Locale locale) => _localizedSimpleValues.isNotEmpty
      ? _localizedSimpleValues.containsKey(locale.languageCode)
      : _localizedValues.containsKey(locale.languageCode);

  @override
  Future<CustomLocalizations> load(Locale locale) =>
      SynchronousFuture<CustomLocalizations>(CustomLocalizations(locale));

  @override
  bool shouldReload(LocalizationsDelegate<CustomLocalizations> old) => false;
}
