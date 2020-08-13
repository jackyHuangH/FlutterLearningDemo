import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/com_list_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/article_item.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:flutter_start/widget/repos_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///公共列表页面
class ComListPage extends StatelessWidget {
  final String labelId;
  final int cid;
  final bool enablePullUp; //是否允许加载更多，分页
  const ComListPage({this.labelId, this.cid, this.enablePullUp = true, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LogUtil.e("ComListPage build......");
    ComListBloc bloc = BlocProvider.of<ComListBloc>(context);
    RefreshController _refreshController = new RefreshController();
    bloc.comListEventStream.listen((event) {
      if (cid == event.cid) {
        //更新列表分页状态
        _refreshController.sendBack(false, event.status);
      }
    });

    return new StreamBuilder(
        stream: bloc.comListStream,
        builder: (BuildContext context, AsyncSnapshot<List<ReposModel>> snapshot) {
          int loadStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
          if (loadStatus == LoadStatus.loading) {
            bloc.onRefresh(labelId: labelId, cid: cid);
          }
          return new RefreshScaffold(
            labelId: cid.toString(),
            loadStatus: loadStatus,
            refreshController: _refreshController,
            onRefresh: ({bool isReload}) {
              return bloc.onRefresh(labelId: labelId, cid: cid);
            },
            enablePullUp: this.enablePullUp,
            onLoadMore: (up) {
              if (enablePullUp) {
                bloc.onLoadMore(labelId: labelId, cid: cid);
              }
            },
            itemCount: snapshot.data == null ? 0 : snapshot.data.length,
            itemBuilder: (context, index) {
              //动态列表就用itemBuilder,否则直接设置child
              ReposModel model = snapshot.data[index];
              return labelId == Ids.titleReposTree ? ReposItem(model) : ArticleItem(model);
            },
          );
        });
  }
}
