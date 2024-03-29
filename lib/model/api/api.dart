//WanAndroid 接口api
import 'package:flutter_start/common/common.dart';

import '../../baselib/data/protocol/base_resp.dart';

class WanAndroidApi {
  static const String USER_LOGIN = "user/login"; //登录
  static const String USER_LOGOUT = "user/logout"; //登出
  static const String USER_REGISTER = "user/register"; //注册

  /// 首页banner http://www.wanandroid.com/banner/json
  static const String BANNER = "banner";

  /// 最新项目tab (首页的第二个tab) http://wanandroid.com/article/listproject/0/json
  static const String ARTICLE_LISTPROJECT = "article/listproject";

  /// 项目分类 http://www.wanandroid.com/project/tree/json
  static const String PROJECT_TREE = "project/tree";

  /// 项目列表数据 http://www.wanandroid.com/project/list/1/json?cid=294
  static const String PROJECT_LIST = "project/list";

  /// 体系数据 http://www.wanandroid.com/tree/json
  static const String TREE = "tree";

  /// 首页文章列表 http://www.wanandroid.com/article/list/0/json
  /// 知识体系下的文章 http://www.wanandroid.com/article/list/0/json?cid=60
  static const String ARTICLE_LIST = "article/list";

  /// 获取公众号列表 http://wanandroid.com/wxarticle/chapters/json
  static const String WXARTICLE_CHAPTERS = "wxarticle/chapters";

  /// 查看某个公众号历史数据 http://wanandroid.com/wxarticle/list/405/1/json
  /// 在某个公众号中搜索历史文章 http://wanandroid.com/wxarticle/list/405/1/json?k=Java
  static const String WXARTICLE_LIST = "wxarticle/list";

  static const String lg_collect_list = "lg/collect/list"; //收藏文章列表
  static const String lg_collect = "lg/collect"; //收藏站内文章
  static const String lg_uncollect_originid = "lg/uncollect_originId"; //取消收藏

  ///组合URL查询条件
  static String getRequestUrl({String path: '', int page, String resType: 'json'}) {
    StringBuffer sb = new StringBuffer(path);
    if (page != null) {
      sb.write('/$page');
    }
    if (resType != null && resType.isNotEmpty) {
      sb.write('/$resType');
    }
    return sb.toString();
  }

  ///接口请求是否失败
  static bool isApiFail(BaseResp baseResp) => baseResp.code != Constant.status_success;

  ///接口请求是否失败
  static bool isApiFailR(BaseRespR baseRespR) => baseRespR.code != Constant.status_success;
}
