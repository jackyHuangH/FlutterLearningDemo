import 'package:flustars/flustars.dart';
import 'package:flutter_start/model/api/api.dart';
import 'package:flutter_start/model/protocol/auth_models.dart';

import '../../baselib/common/common.dart';
import '../../baselib/data/net/dio_util.dart';
import '../../baselib/data/protocol/base_resp.dart';

class UserRepository {
  //登录
  Future<UserModel> login(LoginReq loginReq) async {
    BaseRespR<Map<String, dynamic>> baseResp =
        await DioUtil.getInstance().requestR(Method.post, WanAndroidApi.USER_LOGIN, data: loginReq.toJson());
    if (WanAndroidApi.isApiFailR(baseResp)) {
      return Future.error(baseResp.msg);
    }

    baseResp.response.headers.forEach((name, values) {
      if (name == "set-cookie") {
        //保存cookie到本地
        String cookie = values.toString();
        LogUtil.e("set-cookie", tag: cookie);
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil.getInstance().setCookie(cookie);
      }
    });
    UserModel userModel = UserModel.fromJson(baseResp.data);
    //保存用户信息
    SpUtil.putObject(BaseConstant.keyUserModel, userModel);
    return userModel;
  }

  //注册
  Future<UserModel> register(RegisterReq req) async {
    BaseRespR<Map<String, dynamic>> baseResp =
        await DioUtil.getInstance().requestR(Method.post, WanAndroidApi.USER_REGISTER, data: req.toJson());
    if (WanAndroidApi.isApiFailR(baseResp)) {
      return Future.error(baseResp.msg);
    }

    baseResp.response.headers.forEach((name, values) {
      if (name == "set-cookie") {
        //保存cookie到本地
        String cookie = values.toString();
        LogUtil.e("set-cookie", tag: cookie);
        SpUtil.putString(BaseConstant.keyAppToken, cookie);
        DioUtil.getInstance().setCookie(cookie);
      }
    });
    UserModel userModel = UserModel.fromJson(baseResp.data);
    //保存用户信息
    SpUtil.putObject(BaseConstant.keyUserModel, userModel);
    return userModel;
  }
}
