import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/ui/page/about_page.dart';
import 'package:flutter_start/ui/page/collection_page.dart';
import 'package:flutter_start/ui/page/setting_page.dart';
import 'package:flutter_start/ui/page/share_page.dart';

///首页drawer页面
class MainDrawerPage extends StatefulWidget {
  @override
  _MainDrawerPageState createState() => _MainDrawerPageState();
}

///记录drawer page切换信息
class PageInfo {
  String titleId;
  IconData iconData;
  Widget page;
  bool withScaffold;

  PageInfo(this.titleId, this.iconData, this.page, [this.withScaffold = true]);
}

class _MainDrawerPageState extends State<MainDrawerPage> {
  List<PageInfo> _pageInfoList = new List();

  @override
  void initState() {
    super.initState();
    _pageInfoList.add(PageInfo(
        Ids.titleCollection,
        Icons.collections,
        CollectionPage(
          labelId: Ids.titleCollection,
        )));
    _pageInfoList.add(PageInfo(Ids.titleSetting, Icons.settings, SettingPage()));
    _pageInfoList.add(PageInfo(Ids.titleAbout, Icons.info, AboutPage()));
    _pageInfoList.add(PageInfo(Ids.titleShare, Icons.share, SharePage()));
  }

  @override
  Widget build(BuildContext context) {
    if (Util.isLogin()) {
      ///用户已登录

    } else {
      ///未登录

    }

    return Container();
  }
}
