import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/ui/demos/CitySelectPage.dart';
import 'package:flutter_start/ui/demos/DatePage.dart';
import 'package:flutter_start/ui/demos/PinyinPage.dart';
import 'package:flutter_start/util/navigator_utils.dart';

class DemoItemModel {
  String title;
  Widget page;

  DemoItemModel(this.title, this.page);
}

//flutter demo页面
class MainDemoPage extends StatefulWidget {
  @override
  _MainDemoState createState() => _MainDemoState();
}

class _MainDemoState extends State<MainDemoPage> {
  List<DemoItemModel> mItemList = new List();

  @override
  void initState() {
    super.initState();
    mItemList.add(new DemoItemModel("Github【common_utils】", null));
    mItemList.add(new DemoItemModel("汉字转拼音", new PinyinPage("汉字转拼音")));
    mItemList.add(new DemoItemModel("城市列表", new CitySelectPage("City Select")));
    mItemList.add(new DemoItemModel("Date Util", new DatePage("Date Util")));
//    mItemList.add(new DemoItemModel("Regex Util", new RegexUtilPage("Regex Util")));
//    mItemList.add(new DemoItemModel("Widget Util", new WidgetPage("Widget Util")));
//    mItemList.add(new DemoItemModel("Timer Util", new TimerPage("Timer Util")));
//    mItemList.add(new DemoItemModel("Money Util", new MoneyPage("Money Util")));
//    mItemList.add(new DemoItemModel("Timeline Util", new TimelinePage("Timeline Util")));
//    mItemList.add(new DemoItemModel("圆形/圆角头像", new RoundPortraitPage('圆形/圆角头像')));
//    mItemList.add(new DemoItemModel("获取图片尺寸", new ImageSizePage('获取图片尺寸')));
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildItem(DemoItemModel item, int index) {
      return Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.ac_unit),
            title: Text(item.title),
            onTap: () {
              if (item.page == null) {
                NavigatorUtils.pushWeb(context,
                    url: 'https://github.com/Sky24n/common_utils/blob/master/README.md', title: 'Github【common_utils】');
              } else {
                NavigatorUtils.pushPage(context, page: item.page, pageName: item.title);
              }
            },
          ),
          Divider(
            height: 0.3,
            color: Colours.divider,
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Demos"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          DemoItemModel model = mItemList[index];
          return _buildItem(model, index);
        },
        itemCount: mItemList != null ? mItemList.length : 0,
      ),
    );
  }
}
