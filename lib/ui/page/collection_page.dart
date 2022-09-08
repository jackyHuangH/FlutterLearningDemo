import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/collect_bloc.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/article_item.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:flutter_start/widget/repos_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///我的收藏
class CollectionPage extends StatelessWidget {
  final String labelId;

  const CollectionPage({Key key, this.labelId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController = new RefreshController();
    MainBloc mainBloc = BlocProvider.of<MainBloc>(context);
    CollectBloc collectBloc = BlocProvider.of<CollectBloc>(context);
    collectBloc.setEventSink(mainBloc.homeEventSink);
    //监听分页加载
    mainBloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _refreshController.sendBack(false, event.status);
      }
    });

    return Scaffold(
      appBar: new AppBar(
        title: Text(IntlUtils.getString(context, Ids.titleCollection)),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: collectBloc.collectStream,
        builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          int loadStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == LoadStatus.loading) {
            //初始化加载数据
            Stream.value(1).listen((event) {
              collectBloc.onRefresh(labelId: labelId);
            });
          }

          return RefreshScaffold(
            labelId: labelId,
            loadStatus: loadStatus,
            refreshController: _refreshController,
            onRefresh: ({bool isReload}) {
              return collectBloc.onRefresh(labelId: labelId);
            },
            onLoadMore: (bool up) {
              collectBloc.onLoadMore(labelId: labelId);
            },
            itemCount: snapshot.data != null ? snapshot.data.length : 0,
            itemBuilder: (BuildContext context, int index) {
              ReposModel model = snapshot.data[index];
              return ObjectUtil.isEmpty(model.envelopePic)
                  ? ArticleItem(model)
                  : ReposItem(
                      model,
                      isHome: false,
                    );
            },
          );
        },
      ),
    );
  }
}
