import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/collect_bloc.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/auth_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/ui/page/about_page.dart';
import 'package:flutter_start/ui/page/collection_page.dart';
import 'package:flutter_start/ui/page/main_demos_page.dart';
import 'package:flutter_start/ui/page/setting_page.dart';
import 'package:flutter_start/ui/page/share_page.dart';
import 'package:flutter_start/ui/page/user/user_login_page.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';

import '../../common/common.dart';

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
  PageInfo _logout = PageInfo(Ids.titleSignOut, Icons.power_settings_new, null);
  String _userName;

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

  void _showLogoutDialog(BuildContext buildContext) {
    showDialog(
        context: buildContext,
        builder: (ctx) {
          return AlertDialog(
            content: Text("确定退出登录吗？"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  IntlUtils.getString(ctx, Ids.cancel),
                  style: TextStyles.listExtra,
                ),
                onPressed: () {
                  //取消
                  Navigator.pop(ctx);
                },
              ),
              FlatButton(
                child: Text(
                  IntlUtils.getString(ctx, Ids.confirm),
                  style: TextStyle(color: Theme.of(ctx).primaryColor, fontSize: 12.0),
                ),
                onPressed: () {
                  //退出登录,清空用户信息缓存即可
                  SpUtil.remove(BaseConstant.keyAppToken);
                  Event.sendAppEvent(context, Constant.type_sys_update);
                  Navigator.pop(ctx);
                  Navigator.pop(buildContext);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (Util.isLogin()) {
      ///用户已登录
      if (!_pageInfoList.contains(_logout)) {
        _pageInfoList.add(_logout);
        UserModel userModel = SpUtil.getObj(BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));
        LogUtil.e("已登录信息：${userModel.toString()}");
        _userName = userModel?.username ?? "";
      }
    } else {
      ///未登录
      _userName = "未登录";
      if (_pageInfoList.contains(_logout)) {
        _pageInfoList.remove(_logout);
      }
    }

    return Scaffold(
      body: new Column(
        children: <Widget>[
          new Container(
            height: 190.0,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.only(top: ScreenUtil.getStatusBarH(context), left: 20.0, right: 10.0),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 65.0,
                        height: 65.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(Utils.getImgPath("dog", format: 'jpg')))),
                      ),
                      GestureDetector(
                        onTap: () {
                          //未登录，跳转登录
                          if (!Util.isLogin()) {
                            NavigatorUtils.pushPage(context, page: UserLoginPage());
                          }
                        },
                        child: Text(
                          _userName,
                          style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Gaps.vGap5,
                      Text(
                        "个人简介",
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    child: InkWell(
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 16.0,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Utils.showToast("功能暂未开放哦！");
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 50.0,
            child: Material(
                color: Colors.blue,
                child: InkWell(
                    onTap: () {
                      //跳转到Flutter Demo页面
                      NavigatorUtils.pushPage(context, page: MainDemoPage(), pageName: "Flutter Demos");
                    },
                    child: new Center(
                      child: Text(
                        "Flutter Demo",
                        style: TextStyle(color: Colors.white, fontSize: 15.0),
                      ),
                    ))),
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemCount: _pageInfoList.length,
                itemBuilder: (BuildContext context, int index) {
                  PageInfo _pageInfo = _pageInfoList[index];
                  return new ListTile(
                    dense: false,
                    leading: Icon(_pageInfo.iconData),
                    title: Text(IntlUtils.getString(context, _pageInfo.titleId)),
                    onTap: () {
                      if (_pageInfo.titleId == Ids.titleSignOut) {
                        //弹出退出登录提示框
                        _showLogoutDialog(context);
                      } else if (_pageInfo.titleId == Ids.titleCollection) {
                        //跳转到我的收藏页面
                        NavigatorUtils.pushPage(context,
                            page: BlocProvider<CollectBloc>(
                              child: _pageInfo.page,
                              bloc: CollectBloc(),
                            ),
                            pageName: _pageInfo.titleId,
                            needLogin: Utils.isNeedLogin(_pageInfo.titleId));
                      } else {
                        NavigatorUtils.pushPage(context,
                            page: _pageInfo.page,
                            pageName: _pageInfo.titleId,
                            needLogin: Utils.isNeedLogin(_pageInfo.titleId));
                      }
                    },
                  );
                }),
            flex: 1,
          )
        ],
      ),
    );
  }
}
