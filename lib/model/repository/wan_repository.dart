import 'dart:async';

import 'package:flutter_start/model/api/api.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';

import '../../baselib/data/net/dio_util.dart';
import '../../baselib/data/protocol/base_resp.dart';

class WanRepository {

  ///获取首页banner数据
  Future<List<BannerModel>> getBanner() async {
    BaseResp<List> baseResp =
        await DioUtil.getInstance().request<List>(Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.BANNER));
    List<BannerModel> bannerList;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      bannerList = baseResp.data.map((json) {
        return BannerModel.fromJson(json);
      }).toList();
    }
    return bannerList;
  }

  ///分页Tab项目列表
  Future<List<ReposModel>> getArticleListProject(int page) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil.getInstance().request<Map<String, dynamic>>(
        Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.ARTICLE_LISTPROJECT, page: page));
    List<ReposModel> list;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///分页获取项目列表
  Future<List<ReposModel>> getProjectList({int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil.getInstance().request<Map<String, dynamic>>(
        Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.PROJECT_LIST, page: page),
        data: data);
    List<ReposModel> list;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((value) {
        return ReposModel.fromJson(value);
      }).toList();
    }
    return list;
  }

  ///分页获取文章列表
  Future<List<ReposModel>> getArticleList({int page, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil.getInstance().request<Map<String, dynamic>>(
        Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.ARTICLE_LIST, page: page),
        data: data);
    List<ReposModel> list;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((e) => ReposModel.fromJson(e)).toList();
    }
    return list;
  }

  ///分页获取微信公众号文章列表
  Future<List<ReposModel>> getWxArticleList({int id, int page: 1, data}) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil.getInstance().request<Map<String, dynamic>>(
        Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.WXARTICLE_LIST + '/$id', page: page),
        data: data);
    List<ReposModel> list;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas.map((e) => ReposModel.fromJson(e)).toList();
    }
    return list;
  }

  ///获取项目树列表
  Future<List<TreeModel>> getProjectTree() async {
    BaseResp<List> baseResp = await DioUtil.getInstance()
        .request<List>(Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.PROJECT_TREE));
    List<TreeModel> treeList;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((e) => TreeModel.fromJson(e)).toList();
    }
    return treeList;
  }

  ///获取微信文章章节
  Future<List<TreeModel>> getWxArticleChapters() async {
    BaseResp<List> baseResp = await DioUtil.getInstance()
        .request<List>(Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.WXARTICLE_CHAPTERS));
    List<TreeModel> treeList;
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    if (baseResp.data != null) {
      treeList = baseResp.data.map((e) => TreeModel.fromJson(e)).toList();
    }
    return treeList;
  }

  ///获取体系树数据
  Future<List<TreeModel>> getTree() async{
    BaseResp<List> baseResp=await DioUtil.getInstance()
        .request<List>(Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.TREE));
    List<TreeModel> treeList;
    if(WanAndroidApi.isApiFail(baseResp)){
      return Future.error(baseResp.msg);
    }
    if(baseResp.data!=null){
      treeList=baseResp.data.map((e) => TreeModel.fromJson(e)).toList();
    }
    return treeList;
  }
}
