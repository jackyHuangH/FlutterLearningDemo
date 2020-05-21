import 'package:flutter_start/res/strings.dart';

class Utils {
  /// 获取图片路径
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  /// 是否需要登录
  static bool isNeedLogin(String titleId) => titleId == Ids.titleCollection;
}
