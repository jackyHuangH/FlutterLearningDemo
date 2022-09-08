import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';

import '../common/common.dart';

class CommonKit {
  static String getImgPath(String name, {String format: 'webp'}) {
    return 'assets/images/$name.$format';
  }

  static String getFileName(String urlPath) {
    if (ObjectUtil.isEmpty(urlPath)) return '';
    List<String> listStr = urlPath.split("/");
    String name = listStr[listStr.length - 1];
    return name;
  }

  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }

  static bool isLogin() {
    return ObjectUtil.isNotEmpty(SpUtil.getString(BaseConstant.keyAppToken));
  }
}
