import 'package:flutter_start/model/api/api.dart';
import 'package:flutter_start/model/protocol/common_models.dart';
import 'package:flutter_start/model/protocol/home_models.dart';

import '../../baselib/data/net/dio_util.dart';
import '../../baselib/data/protocol/base_resp.dart';

class CollectRepository {
  ///获取我的收藏列表
  Future<List<ReposModel>> getCollectList(int pageNo) async {
    BaseResp<Map<String, dynamic>> baseResp = await DioUtil.getInstance().request<Map<String, dynamic>>(
        Method.get, WanAndroidApi.getRequestUrl(path: WanAndroidApi.lg_collect_list, page: pageNo));
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    List<ReposModel> list;
    if (baseResp.data != null) {
      ComData comData = ComData.fromJson(baseResp.data);
      list = comData.datas?.map((json) {
        ReposModel model = ReposModel.fromJson(json);
        model.collect = true;
        return model;
      })?.toList();
    }
    return list;
  }

  ///收藏
  Future<bool> collect(int id) async {
    BaseResp baseResp = await DioUtil.getInstance()
        .request(Method.post, WanAndroidApi.getRequestUrl(path: WanAndroidApi.lg_collect, page: id));
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    return true;
  }

  ///取消收藏
  Future<bool> unCollect(int id) async {
    BaseResp baseResp = await DioUtil.getInstance()
        .request(Method.post, WanAndroidApi.getRequestUrl(path: WanAndroidApi.lg_uncollect_originid, page: id));
    if (WanAndroidApi.isApiFail(baseResp)) {
      return Future.error(baseResp.msg);
    }
    return true;
  }
}
