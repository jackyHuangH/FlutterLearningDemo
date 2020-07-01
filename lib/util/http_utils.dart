import 'package:flutter_start/model/protocol/common_models.dart';

///模拟网络请求
class HttpUtils {
  ///获取splash图片
  Future<SplashModel> getSplash() {
    return Future.delayed(Duration(milliseconds: 300), () {
      return SplashModel(
          title: 'flutter常用工具类库',
          content: 'flutter常用工具类库',
          url: 'https://www.jianshu.com/p/425a7ff9d66e',
          imgUrl: 'https://raw.githubusercontent.com/Sky24n/LDocuments/master/AppImgs/flutter_common_utils_a.png');
    });
  }

  Future<ComModel> getRecItem() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return null;
    });
  }

  Future<List<ComModel>> getRecList() async {
    return Future.delayed(new Duration(milliseconds: 300), () {
      return List();
    });
  }
}
