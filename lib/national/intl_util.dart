import 'package:flutter/material.dart';
import 'package:flutter_start/national/custom_localization.dart';

/// 推荐使用IntlUtil获取字符串
class IntlUtils {
  static String getString(BuildContext context, String id,
          {String languageCode, String countryCode, List<Object> params}) =>
      CustomLocalizations.of(context)
          .getString(id, languageCode: languageCode, countryCode: countryCode, params: params);
}
