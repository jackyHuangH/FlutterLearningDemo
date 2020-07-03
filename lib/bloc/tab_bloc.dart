import 'dart:collection';

import 'package:base_library/base_library.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/repository/wan_repository.dart';
import 'package:flutter_start/res/index.dart';
import 'package:rxdart/rxdart.dart';

///Tab 相关bloc
class TabBloc extends BlocBase {
  BehaviorSubject<List<TreeModel>> _tabTree = new BehaviorSubject<List<TreeModel>>();

  Sink<List<TreeModel>> get _tabTreeSink => _tabTree.sink;

  Stream<List<TreeModel>> get tabTreeStream => _tabTree.stream;

  List<TreeModel> _treeList;

  WanRepository _wanRepository = new WanRepository();

  @override
  Future getData({String labelId, int page}) {
    LogUtil.e("Tab_bloc:getData");
    switch (labelId) {
      case Ids.titleReposTree:
        return getProjectTree(labelId);
        break;
      case Ids.titleWxArticleTree:
        return getWxArticleTree(labelId);
        break;
      case Ids.titleSystemTree:
        return getSystemTree(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    return getData(labelId: labelId);
  }

  ///绑定体系数据
  void bindSystemData(TreeModel model) {
    if (model == null) return;
    _treeList = model.children;
  }

  ///获取项目树
  Future getProjectTree(String labelId) {
    return _wanRepository.getProjectTree().then((list) {
      _tabTreeSink.add(new UnmodifiableListView<TreeModel>(list));
    });
  }

  ///获取微信章节树
  Future getWxArticleTree(String labelId) {
    return _wanRepository.getWxArticleChapters().then((list) {
      _tabTreeSink.add(new UnmodifiableListView<TreeModel>(list));
    });
  }

  ///获取体系分类树
  Future getSystemTree(String labelId) {
    return Future.delayed(new Duration(milliseconds: 300)).then((_) {
      _tabTreeSink.add(new UnmodifiableListView<TreeModel>(_treeList));
    });
  }

  @override
  void dispose() {
    _tabTree.close();
  }
}
