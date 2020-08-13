import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/com_list_bloc.dart';
import 'package:flutter_start/bloc/tab_bloc.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/ui/page/com_list_page.dart';
import 'package:flutter_start/widget/widgets.dart';
import 'package:rxdart/rxdart.dart';

///Tab+viewpager切换页面
class TabPage extends StatefulWidget {
  final String labelId;
  final String title;
  final String titleId;
  final TreeModel treeModel;
  final bool enablePullUp;

  const TabPage({this.labelId, this.title, this.titleId, this.treeModel, this.enablePullUp = true, Key key})
      : super(key: key);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  List<BlocProvider<ComListBloc>> _children = new List();

  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = BlocProvider.of<TabBloc>(context);
    tabBloc.bindSystemData(widget.treeModel);

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text(
          widget.title ?? IntlUtils.getString(context, widget.titleId),
        ),
      ),
      body: StreamBuilder(
        stream: tabBloc.tabTreeStream,
        builder: (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
          if (snapshot.data == null) {
            //初始化获取数据
            Observable.just(1).delay(Duration(milliseconds: 0)).listen((event) {
              tabBloc.getData(labelId: widget.labelId);
            });
            return new ProgressView();
          }
          //遍历所有tab，创建对应共用列表页面
          _children = snapshot.data
              .map((TreeModel treeModel) => new BlocProvider(
                  child: new ComListPage(
                    labelId: widget.labelId,
                    cid: treeModel.id,
                    enablePullUp: widget.enablePullUp,
                  ),
                  bloc: new ComListBloc()))
              .cast<BlocProvider<ComListBloc>>()
              .toList();
          return DefaultTabController(
            length: snapshot.data == null ? 0 : snapshot.data.length,
            child: Column(
              children: <Widget>[
                new Material(
                  color: Theme.of(context).primaryColor,
                  child: SizedBox(
                    height: 48.0,
                    width: double.infinity,
                    child: new TabBar(
                        isScrollable: true,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: snapshot.data
                            ?.map((e) => new Tab(
                                  text: e.name,
                                ))
                            ?.toList()),
                  ),
                ),

                ///TabBarView+TabBar+DefaultTabController组成tab+viewpager效果
                new Expanded(child: new TabBarView(children: _children))
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    //释放所有tab页面资源
    for (var blocProvider in _children) {
      if (blocProvider != null) blocProvider.bloc.dispose();
    }
    super.dispose();
  }
}
