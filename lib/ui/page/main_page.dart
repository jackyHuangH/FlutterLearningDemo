import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/ui/page/event_page.dart';
import 'package:flutter_start/ui/page/home_page.dart';
import 'package:flutter_start/ui/page/main_drawer_page.dart';
import 'package:flutter_start/ui/page/repos_page.dart';
import 'package:flutter_start/ui/page/search_page.dart';
import 'package:flutter_start/ui/page/system_page.dart';
import 'package:flutter_start/util/navigator_utils.dart';

final List<_Page> _allPages = <_Page>[
  _Page(Ids.titleHome),
  _Page(Ids.titleRepos),
  _Page(Ids.titleEvents),
  _Page(Ids.titleSystem),
];

class _Page {
  final String labelId;

  _Page(this.labelId);
}

///主页
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: AppBar(
          //用户头像
          leading: Builder(
            builder: (BuildContext ctx) {
              return IconButton(
                icon: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(Util.getImgPath("dog", format: 'jpg')),
                      )),
                ),
                onPressed: () {
                  //点击头像展开左边侧拉条
                  Scaffold.of(ctx).openDrawer();
                },
              );
            },
          ),
          centerTitle: true,
          //中间tablayout标题
          title: TabLayout(),
          //搜索按钮
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //搜索
                NavigatorUtils.pushPage(context, page: SearchPage(), pageName: "SearchPage");
              },
            )
          ],
        ),
        body: TabBarViewLayout(),
        drawer: Drawer(
          child: MainDrawerPage(),
        ),
      ),
    );
  }
}

///顶部tablayout
class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabBar(
        isScrollable: true,
        labelPadding: EdgeInsets.all(12.0),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: _allPages.map((_Page page) => Tab(text: IntlUtils.getString(context, page.labelId))).toList());
  }
}

///主要内容
class TabBarViewLayout extends StatelessWidget {
  Widget _buildTabView(BuildContext context, _Page page) {
    String _labelId = page.labelId;
    Widget target;
    switch (_labelId) {
      case Ids.titleHome:
        target = HomePage(labelId: _labelId);
        break;
      case Ids.titleRepos:
        target = ReposPage(labelId: _labelId);
        break;
      case Ids.titleEvents:
        target = EventsPage(labelId: _labelId);
        break;
      case Ids.titleSystem:
        target = SystemPage(labelId: _labelId);
        break;
      default:
        target = Container();
        break;
    }
    return target;
  }

  @override
  Widget build(BuildContext context) {
    return TabBarView(children: _allPages.map((_Page page) => _buildTabView(context, page)).toList());
  }
}
