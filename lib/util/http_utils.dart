import 'dart:async';

import 'package:flutter_start/model/models.dart';

///模拟网络请求
class HttpUtils {
  ///获取splash图片
  static Future<SplashModel> getSplash() {
    return Future.delayed(Duration(milliseconds: 100), () {
      return SplashModel(
          title: 'flutter常用工具类库',
          content: 'flutter常用工具类库',
          url: 'https://www.jianshu.com/p/425a7ff9d66e',
          imgUrl: 'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png');
    });
  }
}
