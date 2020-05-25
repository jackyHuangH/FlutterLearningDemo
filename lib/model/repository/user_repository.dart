import 'package:base_library/base_library.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/model/api/api.dart';
import 'package:flutter_start/model/protocol/models.dart';

class UserRepository {
  //登录
  Future<UserModel> login(LoginReq loginReq) async {
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil.getInstance()
        .requestR(Method.post, WanAndroidApi.USER_LOGIN, data: loginReq.toJson());
    if (baseResp.code != Constant.status_success) {
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
    BaseRespR<Map<String, dynamic>> baseResp = await DioUtil.getInstance()
        .requestR(Method.post, WanAndroidApi.USER_REGISTER, data: req.toJson());
    if (baseResp.code != Constant.status_success) {
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
