import 'package:base_library/base_library.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/local_models.dart';

import '../model/local_models.dart';

class SpHelper {
  /// T 用于区分存储类型
  /// Example.
  /// SpHelper.putObject<int>(key, value);
  /// SpHelper.putObject<double>(key, value);
  /// SpHelper.putObject<bool>(key, value);
  /// SpHelper.putObject<String>(key, value);
  /// SpHelper.putObject<List>(key, value);
  ///
  /// SpHelper.putObject(key, UserModel);
  ///

  static void putObject<T>(String key, Object value) {
    switch (T) {
      case int:
        SpUtil.putInt(key, value);
        break;
      case double:
        SpUtil.putDouble(key, value);
        break;
      case bool:
        SpUtil.putBool(key, value);
        break;
      case String:
        SpUtil.putString(key, value);
        break;
      case List:
        SpUtil.putStringList(key, value);
        break;
      default:
        SpUtil.putObject(key, value);
        break;
    }
  }

  static Object getObject<T>(String key) {
    Map map = SpUtil.getObject(key);
    if (map == null) {
      return null;
    }
    Object obj;
    switch (T) {
      case SplashModel:
        obj = SplashModel.fromJson(map);
        break;
      case LanguageModel:
        obj = LanguageModel.fromJson(map);
        break;
      case VersionModel:
        obj = VersionModel.fromJson(map);
        break;
      default:
        break;
    }
    return obj;
  }

  static const def_theme_color = "deepPurpleAccent";

  ///获取主题颜色
  static String getThemeColor() =>
      SpUtil.getString(Constant.key_theme_color, defValue: def_theme_color);
}
