import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:flutter_start/widget/repos_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///项目页面
class ReposPage extends StatelessWidget {
  final String labelId;

  const ReposPage({this.labelId, Key key}) : super(key: key);

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
    return StreamBuilder(
        stream: bloc.reposStream,
        builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          int loadingStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadingStatus == LoadStatus.loading) {
            //初始化数据
            Observable.just(1).listen((event) {
              bloc.onRefresh(labelId: labelId);
            });
          }
          return RefreshScaffold(
            labelId: labelId,
            loadStatus: loadingStatus,
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            refreshController: _refreshController,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId);
            },
            onLoadMore: (up) {
              bloc.onLoadMore(labelId: labelId);
            },
            itemBuilder: (BuildContext context, int pos) {
              ReposModel model = snapshot.data[pos];
              return new ReposItem(
                model,
                isHome: false,
              );
            },
          );
        });
  }
}
