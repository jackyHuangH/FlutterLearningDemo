import 'package:flutter/material.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  /// 获取图片路径
  static String getImgPath(String name, {String format: 'png'}) {
    return 'assets/images/$name.$format';
  }

  /// 弹Toast
  static void showToast(String text) {
    Fluttertoast.showToast(
        msg: text.isNotEmpty ? text : "",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// 是否需要登录
  static bool isNeedLogin(String titleId) => titleId == Ids.titleCollection;
}
