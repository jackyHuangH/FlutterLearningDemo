import 'dart:collection';

import 'package:base_library/base_library.dart';
import 'package:flutter_start/bloc/bloc_base.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';
import 'package:flutter_start/model/repository/wan_repository.dart';
import 'package:flutter_start/res/index.dart';
import 'package:flutter_start/util/http_utils.dart';
import 'package:rxdart/rxdart.dart';

class MainBloc implements BlocBase {
  ///-----------------home--------------------------//
  BehaviorSubject<StatusEvent> _homeEvent = BehaviorSubject<StatusEvent>();

  Stream<StatusEvent> get homeEventStream => _homeEvent.stream.asBroadcastStream();

  Sink<StatusEvent> get homeEventSink => _homeEvent.sink;

  BehaviorSubject<List<BannerModel>> _bannerEvent = BehaviorSubject<List<BannerModel>>();

  Stream<List<BannerModel>> get bannerStream => _bannerEvent.stream;

  Sink<List<BannerModel>> get _bannerSink => _bannerEvent.sink;

  BehaviorSubject<ComModel> _recItem = BehaviorSubject<ComModel>();

  Stream<ComModel> get recItemStream => _recItem.stream.asBroadcastStream();

  Sink<ComModel> get _recItemSink => _recItem.sink;

  ComModel hotRecModel;

  BehaviorSubject<List<ReposModel>> _recRepos = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get recReposStream => _recRepos.stream;

  Sink<List<ReposModel>> get _recReposSink => _recRepos.sink;

  BehaviorSubject<List<ReposModel>> _recWxArticles = BehaviorSubject<List<ReposModel>>();

  Stream<List<ReposModel>> get recWxArticleStream => _recWxArticles.stream;

  Sink<List<ReposModel>> get _recWxArticleSink => _recWxArticles.sink;

  ///------------------repos-----------------------------
  int _reposPage = 0;

  ///*******************************************//
  WanRepository wanRepository = new WanRepository();
  HttpUtils httpUtils = new HttpUtils();

  @override
  Future getData({String labelId, int page}) {
    switch (labelId) {
      case Ids.titleHome:
        return getHomeData(labelId);
        break;
      default:
        return Future.delayed(new Duration(seconds: 1));
        break;
    }
  }

  @override
  Future onLoadMore({String labelId}) {
    // TODO: implement onLoadMore
    return null;
  }

  @override
  Future onRefresh({String labelId}) {
    switch (labelId) {
      case Ids.titleHome:
        getHotRecItem();
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
    return wanRepository.getBanner().then((list) {
      _bannerSink.add(UnmodifiableListView<BannerModel>(list));
    });
  }

  ///获取首页推荐项目列表6条
  Future getRecRepos(String labelId) async {
    ComReq _comReq = new ComReq(402);
    wanRepository.getProjectList(data: _comReq.toJson()).then((list) {
      //只截取前6条
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recReposSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  ///获取首页推荐微信公众号列表，只取6条
  void getRecWxArticles(String labelId) async {
    int _id = 408;
    wanRepository.getWxArticleList(id: _id).then((list) {
      if (list.length > 6) {
        list = list.sublist(0, 6);
      }
      _recWxArticleSink.add(UnmodifiableListView<ReposModel>(list));
    });
  }

  @override
  void dispose() {
    //释放资源
    _homeEvent.close();
    _bannerEvent.close();
    _recItem.close();
    _recRepos.close();
    _recWxArticles.close();
  }
}
