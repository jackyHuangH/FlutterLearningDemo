import 'dart:collection';

import 'package:flustars/flustars.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/model/repository/wan_repository.dart';
import 'package:flutter_start/res/index.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

///通用列表bloc
class ComListBloc extends BlocBase {
  BehaviorSubject<List<ReposModel>> _comListData = new BehaviorSubject<List<ReposModel>>();

  Sink<List<ReposModel>> get _comListSink => _comListData.sink;

  Stream<List<ReposModel>> get comListStream => _comListData.stream;

  //event用于控制列表分页加载状态
  BehaviorSubject<StatusEvent> _comListEvent = new BehaviorSubject<StatusEvent>();

  Sink<StatusEvent> get _comListEventSink => _comListEvent.sink;

  ///如果一个流是单订阅模式 却想多次订阅，可以通过asBroadcastStream （）方法来修改
  Stream<StatusEvent> get comListEventStream => _comListEvent.stream.asBroadcastStream();

  List<ReposModel> comList;
  int _comListPage = 0;

  WanRepository _wanRepository = new WanRepository();

  @override
  Future getData({String labelId, int cid, int page}) {
    switch (labelId) {
      case Ids.titleReposTree:
        //项目列表
        return getRepos(labelId, cid, page);
        break;
      case Ids.titleWxArticleTree:
        //微信文章列表
        return getWxArticles(labelId, cid, page);
        break;
      case Ids.titleSystemTree:
        //体系文章列表
        return getArticles(labelId, cid, page);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId, int cid}) {
    int _page = 0;
    _page = ++_comListPage;
    return getData(labelId: labelId, cid: cid, page: _page);
  }

  @override
  Future onRefresh({String labelId, int cid}) {
    switch (labelId) {
      case Ids.titleReposTree:
        //项目分类树
        _comListPage = 1;
        break;
      case Ids.titleWxArticleTree:
        //微信文章分类树
        _comListPage = 1;
        break;
      case Ids.titleSystemTree:
        //体系分类树
        _comListPage = 0;
        break;
      default:
        break;
    }
    return getData(labelId: labelId, cid: cid, page: _comListPage);
  }

  //获取项目列表
  Future getRepos(String labelId, int cid, int page) async {
    ComReq _comReq = new ComReq(cid);
    return _wanRepository.getProjectList(page: page, data: _comReq.toJson()).then((list) {
      if (comList == null) comList = new List();
      if (page == 1) {
        //刷新数据，清空缓存
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(new UnmodifiableListView<ReposModel>(comList));
      //更新列表分页状态
      _comListEventSink.add(
          new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle, cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  //获取微信文章列表
  Future getWxArticles(String labelId, int cid, int page) async {
    return _wanRepository.getWxArticleList(id: cid, page: page).then((list) {
      if (comList == null) comList = new List();
      if (page == 1) {
        //刷新数据，清空缓存
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(new UnmodifiableListView<ReposModel>(comList));
      _comListEventSink.add(
          new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle, cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  //获取文章列表
  Future getArticles(String labelId, int cid, int page) async {
    ComReq comReq = new ComReq(cid);
    return _wanRepository.getArticleList(page: page, data: comReq.toJson()).then((list) {
      if (comList == null) comList = new List();
      if (page == 0) {
        //刷新数据，清空缓存
        comList.clear();
      }
      comList.addAll(list);
      _comListSink.add(new UnmodifiableListView<ReposModel>(comList));
      _comListEventSink.add(
          new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle, cid: cid));
    }).catchError((_) {
      _comListPage--;
      _comListEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  @override
  void dispose() {
    _comListData.close();
    _comListEvent.close();
  }
}
