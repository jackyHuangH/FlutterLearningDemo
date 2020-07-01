import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/ui/page/user/user_login_page.dart';
import 'package:flutter_start/widget/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigatorUtils {

  static void pushPage(BuildContext context, {@required Widget page, String pageName, bool needLogin: false}) {
    if (context == null || page == null) {
      return;
    }
    if (needLogin && !Util.isLogin()) {
      ///需要登录但未登录时，跳转到登录页
      pushPage(context, page: UserLoginPage());
    }
    Navigator.push(context, MaterialPageRoute<void>(builder: (ctx) => page));
  }

  static void pushWeb(BuildContext context, {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) {
      return;
    }
    if (url.endsWith('.apk')) {
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
