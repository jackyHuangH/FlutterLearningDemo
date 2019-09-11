import 'package:base_library/base_library.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/widget/web_scaffold.dart';
import 'package:url_launcher/url_launcher.dart';

class NavigationUtils {
  static void pushWeb(BuildContext context, {String title, String titleId, String url, bool isHome: false}) {
    if (context == null || ObjectUtil.isEmpty(url)) {
      return;
    }
    if (url.endsWith('.apk')) {
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
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
