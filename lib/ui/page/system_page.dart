import 'package:flutter/material.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/bloc/main_bloc.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/refresh_scaffold.dart';
import 'package:flutter_start/widget/tree_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///体系页面
class SystemPage extends StatelessWidget {
  final String labelId;

  const SystemPage({this.labelId, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController _refreshController = new RefreshController();
    MainBloc bloc = BlocProvider.of<MainBloc>(context);

    return StreamBuilder(
      stream: bloc.treeStream,
      builder: (BuildContext context, AsyncSnapshot<List<TreeModel>> snapshot) {
        //初始化加载数据
        int loadStatus = Utils.getLoadStatus(snapshot.hasError, snapshot.data);
        if (loadStatus == LoadStatus.loading) {
          Stream.value(1).listen((event) {
            bloc.onRefresh(labelId: labelId);
          });
        }
        return RefreshScaffold(
          labelId: labelId,
          loadStatus: loadStatus,
          refreshController: _refreshController,
          onRefresh: ({bool isReload}) {
            return bloc.onRefresh(labelId: labelId);
          },
          enablePullUp: false,
          onLoadMore: (bool up) {},
          itemCount: snapshot.data == null ? 0 : snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            TreeModel model = snapshot.data[index];
            return TreeItem(model);
          },
        );
      },
    );
  }
}
