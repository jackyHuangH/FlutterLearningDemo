import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/article_item.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

//用于初始化加载数据
bool _hasInit = false;

///动态页面
class EventsPage extends StatelessWidget {
  final String labelId;

  const EventsPage({this.labelId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RefreshController _refreshController = new RefreshController();
    MainBloc bloc = BlocProvider.of<MainBloc>(context);

    //监听分页加载
    bloc.homeEventStream.listen((event) {
      if (labelId == event.labelId) {
        _refreshController.sendBack(false, event.status);
      }
    });

    //初始化数据
    if (!_hasInit) {
      _hasInit = true;
      Observable.just(1).listen((event) {
        bloc.onRefresh(labelId: labelId);
      });
    }

    return StreamBuilder(
      stream: bloc.eventsStream,
      builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
        // 动态列表构建
        return RefreshScaffold(
          labelId: labelId,
          loadStatus: Utils.getLoadStatus(snapshot.hasError, snapshot.data),
          refreshController: _refreshController,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId);
          },
          onLoadMore: (bool up) {
            bloc.onLoadMore(labelId: labelId);
          },
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            ReposModel model = snapshot.data[index];
            return new ArticleItem(model);
          },
        );
      },
    );
  }
}
