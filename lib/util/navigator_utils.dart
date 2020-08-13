import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/tab_bloc.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/ui/page/tab_page.dart';
import 'package:flutter_start/ui/page/user/user_login_page.dart';
import 'package:flutter_start/widget/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

///Navigator封装
class NavigatorUtils {
  ///跳转普通页面
  static void pushPage(BuildContext context, {@required Widget page, String pageName, bool needLogin: false}) {
    if (context == null || page == null) {
      return;
    }
    if (needLogin && !Util.isLogin()) {
      ///需要登录但未登录时，跳转到登录页
      pushPage(context, page: UserLoginPage());
      return;
    }
    Navigator.push(context, MaterialPageRoute<void>(builder: (ctx) => page));
  }

  ///跳转到tab+viewpager页面
  static void pushTabPage(BuildContext context,
      {String labelId, String title, String titleId, TreeModel treeModel, bool enablePullUp = true}) {
    if (context == null) {
      return;
    }
    Navigator.push(context, new MaterialPageRoute<void>(builder: (ctx) {
      return BlocProvider<TabBloc>(
        child: new TabPage(
          labelId: labelId,
          titleId: titleId,
          title: title,
          treeModel: treeModel,
          enablePullUp: enablePullUp,
        ),
        bloc: new TabBloc(),
      );
    }));
  }

  ///打开webview
  static void pushWeb(BuildContext context, {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) {
      return;
    }
    if (url.endsWith('.apk')) {
      //调用系统浏览器打开
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute<void>(
              builder: (ctx) => WebScaffold(
                    title: title,
                    titleId: titleId,
                    url: url,
                  )));
    }
  }

  ///调用系统浏览器打开网址
  static void launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'could not launch$url';
    }
  }
}
