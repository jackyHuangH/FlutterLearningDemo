import 'dart:collection';

import 'package:flustars/flustars.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/model/repository/collect_repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///收藏相关接口数据处理
class CollectBloc implements BlocBase {
  BehaviorSubject<List<ReposModel>> _collectData = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get collectStream => _collectData.stream.asBroadcastStream();

  Sink<List<ReposModel>> get _collectSink => _collectData.sink;

  List<ReposModel> _collectList;
  int _collectPage = 0;

  CollectRepository _collectRepository = new CollectRepository();

  ///分页加载状态更新入口
  Sink<StatusEvent> _loadEventSink;

  void setEventSink(Sink<StatusEvent> value) {
    _loadEventSink = value;
  }

  @override
  Future getData({String labelId, int page}) {
    return _collectRepository.getCollectList(page).then((list) {
      if (_collectList == null) {
        _collectList = new List();
      }
      if (page == 0) {
        _collectList.clear();
      }
      _collectList.addAll(list);
      _collectSink.add(new UnmodifiableListView<ReposModel>(_collectList));
      _loadEventSink
          ?.add(new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle));
    }).catchError((e) {
      if (ObjectUtil.isEmpty(_collectList)) {
        _collectData.sink.addError("error:$e");
      }
      _collectPage--;
      _loadEventSink?.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  @override
  Future onLoadMore({String labelId}) {
    _collectPage++;
    return getData(labelId: labelId, page: _collectPage);
  }

  @override
  Future onRefresh({String labelId}) {
    _collectPage = 0;
    return getData(labelId: labelId, page: _collectPage);
  }

  @override
  void dispose() {
    _collectData.close();
  }
}
