import 'dart:collection';

import 'package:azlistview/azlistview.dart';
import 'package:base_library/base_library.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/model/repository/collect_repository.dart';
import 'package:flutter_start/model/repository/wan_repository.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/http_utils.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements BlocBase {
  ///----------------common,用于控制分页加载--------------------
  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();

  Stream<StatusEvent> get homeEventStream => _homeEvent.stream.asBroadcastStream();

  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;

  ///-----------------home--------------------------//
  BehaviorSubject<List<BannerModel>> _bannerEvent = BehaviorSubject<List<BannerModel>>();

  Stream<List<BannerModel>> get bannerStream => _bannerEvent.stream;

  Sink<List<BannerModel>> get _bannerSink => _bannerEvent.sink;

  BehaviorSubject<List<ReposModel>> _recRepos = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;

  BehaviorSubject<List<ReposModel>> _recWxArticles = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get recWxArticleStream => _recWxArticles.stream;

  Sink<List<ReposModel>> get _recWxArticleSink => _recWxArticles.sink;

  ///-------------------repos项目----------------------------
  BehaviorSubject<List<ReposModel>> _reposData = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get reposStream => _reposData.stream;

  Sink<List<ReposModel>> get _reposSink => _reposData.sink;

  List<ReposModel> _reposList;
  int _reposPage = 0;

  ///-------------------events动态----------------------------
  BehaviorSubject<List<ReposModel>> _eventsData = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get eventsStream => _eventsData.stream;

  Sink<List<ReposModel>> get _eventsSink => _eventsData.sink;

  List<ReposModel> _eventsList;
  int _eventsPage = 0;

  ///-------------------system体系----------------------------
  BehaviorSubject<List<TreeModel>> _treeData = BehaviorSubject<List<TreeModel>>();

  Stream<List<TreeModel>> get treeStream => _treeData.stream;

  Sink<List<TreeModel>> get _treeSink => _treeData.sink;

  List<TreeModel> _treeList;

  ///-----------------personal-----------------------

  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();

  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();

  Sink<ComModel> get _recItemSink => _recItem.sink;

  ComModel hotRecModel;

  ///*******************************************//
  WanRepository _wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();
  CollectRepository _collectRepository = new CollectRepository();

  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      case Ids.titleHome:
        return getHomeData(labelId);
        break;
      case Ids.titleRepos:
        return getArticleListProject(labelId, page);
        break;
      case Ids.titleEvents:
        return getEventArticleList(labelId, page);
        break;
      case Ids.titleSystem:
        return getTree(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    int _page = 0;
    switch (labelId) {
      case Ids.titleHome:
        break;
      case Ids.titleRepos:
        _page = ++_reposPage;
        break;
      case Ids.titleEvents:
        _page = ++_eventsPage;
        break;
      case Ids.titleSystem:
        break;
      default:
        break;
    }
    return getData(labelId: labelId, page: _page);
  }

  @override
  Future onRefresh({String labelId}) {
    switch (labelId) {
      case Ids.titleHome:
        getHotRecItem();
        break;
      case Ids.titleRepos:
        _reposPage = 0;
        break;
      case Ids.titleEvents:
        _eventsPage = 0;
        break;
      case Ids.titleSystem:
        break;
      default:
        break;
    }
    LogUtil.e("onRefresh labelId: $labelId" + "   _reposPage: $_reposPage");
    return getData(labelId: labelId, page: 0);
  }

  Future getHomeData(String labelId) {
    getRecRepos(labelId);
    getRecWxArticles(labelId);
    return getBanner();
  }

  Future getHotRecItem() async {
    return httpUtils.getRecItem().then((value) {
      hotRecModel = value;
      _recItemSink.add(value);
    });
  }

  //获取banner列表
  Future getBanner() {
    return _wanRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }

  ///获取首页推荐项目列表6条
  Future getRecRepos(String labelId) async {
    ComReq _comReq = new ComReq(402);
    _wanRepository.getProjectList(data: _comReq.toJson()).then((list) {
      //只截取前6条
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recReposSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  ///获取首页推荐微信公众号列表，只取6条
  Future getRecWxArticles(String labelId) async {
    int _id = 408;
    _wanRepository.getWxArticleList(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  ///获取Tab项目列表
  Future getArticleListProject(String labelId, int page) async {
    return _wanRepository.getArticleListProject(page).then((list) {
      if (_reposList == null) _reposList = new List();
      if (page == 0) _reposList.clear();
      _reposList.addAll(list);
      _reposSink.add(new UnmodifiableListView<ReposModel>(_reposList));
      homeEventSink.add(new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle));
    }).catchError((e) {
      if (ObjectUtil.isEmpty(_reposList)) {
        _reposData.sink.addError("error:list is empty");
      }
      _reposPage--;
      homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  ///获取Tab动态列表
  Future getEventArticleList(String labelId, int page) async {
    return _wanRepository.getArticleList(page: page).then((list) {
      if (_eventsList == null) _eventsList = new List();
      if (page == 0) _eventsList.clear();
      _eventsList.addAll(list);
      _eventsSink.add(new UnmodifiableListView<ReposModel>(_eventsList));
      homeEventSink.add(new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle));
    }).catchError((e) {
      if (ObjectUtil.isEmpty(_eventsList)) {
        _eventsData.sink.addError("error:list is empty");
      }
      _eventsPage--;
      homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  ///获取Tab体系列表
  Future getTree(String labelId) async {
    return _wanRepository.getTree().then((list) {
      if (_treeList == null) _treeList = new List();
      //按拼音首字母重新排序
      for (int i = 0, size = list.length; i < size; i++) {
        TreeModel model = list[i];
        String tag = Utils.getPinyin(model.name);
        if (RegExp("[A-Z]").hasMatch(tag)) {
          list[i].tagIndex = tag;
        } else {
          list[i].tagIndex = "#";
        }
      }
      SuspensionUtil.sortListBySuspensionTag(list);

      _treeList.clear();
      _treeList.addAll(list);
      _treeSink.add(new UnmodifiableListView<TreeModel>(_treeList));
      homeEventSink.add(new StatusEvent(labelId, ObjectUtil.isEmpty(list) ? RefreshStatus.noMore : RefreshStatus.idle));
    }).catchError((e) {
      if (ObjectUtil.isEmpty(_treeList)) {
        _treeData.sink.addError("error:list is empty");
      }
      homeEventSink.add(new StatusEvent(labelId, RefreshStatus.failed));
    });
  }

  ///收藏，取消收藏
  void doCollect(int id, bool isCollect) {
    if (isCollect) {
      _collectRepository.collect(id).then((ok) {
        if (ok) {
          afterCollectStateChanged(id, isCollect);
        }
      });
    } else {
      _collectRepository.unCollect(id).then((ok) {
        if (ok) {
          afterCollectStateChanged(id, isCollect);
        }
      });
    }
  }

  ///收藏，取消收藏后刷新列表
  void afterCollectStateChanged(int id, bool isCollect) {
    if (!ObjectUtil.isEmpty(_reposList)) {
      _reposList?.forEach((model) {
        if (id == model.id) {
          model.collect = isCollect;
        }
        return model;
      });
      _reposSink.add(UnmodifiableListView<ReposModel>(_reposList));
    }
    if (!ObjectUtil.isEmpty(_eventsList)) {
      _eventsList?.forEach((model) {
        if (id == model.id) {
          model.collect = isCollect;
        }
        return model;
      });
      _eventsSink.add(UnmodifiableListView<ReposModel>(_eventsList));
    }
  }

  @override
  void dispose() {
    //释放资源
    _homeEvent.close();
    _bannerEvent.close();
    _recItem.close();
    _recRepos.close();
    _recWxArticles.close();
    _reposData.close();
    _eventsData.close();
    _treeData.close();
  }
}
