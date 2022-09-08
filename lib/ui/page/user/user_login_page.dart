import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/auth_models.dart';
import 'package:flutter_start/model/repository/user_repository.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/ui/page/user/user_register_page.dart';
import 'package:flutter_start/util/navigator_utils.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/login_widget.dart';
import 'package:rxdart/rxdart.dart';

import '../../../baselib/common/common.dart';
import '../../../baselib/res/colors.dart';
import '../../../baselib/res/styles.dart';
import '../../../baselib/util/commonkit.dart';
import '../../../baselib/util/route_util.dart';

///登录页
class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            CommonKit.getImgPath("ic_login_bg"),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          new LoginBody()
        ],
      ),
    );
  }
}

class LoginBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _userNameController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    UserRepository userRepository = UserRepository();
    //显示历史用户名
    UserModel historyUserModel =
        SpUtil.getObj(BaseConstant.keyUserModel, (v) => UserModel.fromJson(v));
    if (historyUserModel != null) {
      String historyName = historyUserModel.username;
      _userNameController.text = historyName.isNotEmpty ? historyName : "";
    }
    //登录
    void _doLogin() {
      String userName = _userNameController.text;
      String password = _passwordController.text;
      if (userName.isEmpty || userName.length < 6) {
        var msg = IntlUtils.getString(context,
            userName.isEmpty
                ? Ids.user_login_name_empty
                : Ids.user_login_name_length_too_short);
        // Utils.showToast(msg);
        CommonKit.showSnackBar(context, msg);
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Utils.showToast(IntlUtils.getString(
            context,
            password.isEmpty
                ? Ids.user_login_pwd_empty
                : Ids.user_login_pwd_length_too_short));
        return;
      }
      LoginReq loginReq = new LoginReq(userName, password);
      userRepository.login(loginReq).then((value) {
        LogUtil.e("LoginResp data:${value.toString()}");
        Utils.showToast(IntlUtils.getString(context, Ids.user_login_success));
        //发送刷新数据通知，延迟跳转主页
        Stream.value(1).delay(Duration(microseconds: 500)).listen((event) {
          Event.sendAppEvent(context, Constant.type_refresh_all);
          RouteUtil.goMain(context);
        });
      }).catchError((error) {
        LogUtil.e("LoginResp error: ${error.toString()}");
        Utils.showToast(error.toString());
      });
    }

    return new Column(children: <Widget>[
      Expanded(child: new Container()),
      Expanded(
        flex: 3,
        child: new Container(
            margin: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                LoginInputItem(
                  prefixIcon: Icons.person,
                  hintText: IntlUtils.getString(context, Ids.user_name),
                  controller: _userNameController,
                ),
                Gaps.vGap5,
                LoginInputItem(
                  prefixIcon: Icons.lock,
                  hasSuffixIcon: true,
                  hintText: IntlUtils.getString(context, Ids.user_pwd),
                  controller: _passwordController,
                ),
                Container(
                  margin: EdgeInsets.only(top: 15.0),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    child: InkWell(
                      child: Text(
                        IntlUtils.getString(context, Ids.user_forget_pwd),
                        style: TextStyle(color: Colours.gray_f0, fontSize: 14),
                      ),
                    ),
                    onTap: () {
                      Utils.showToast("找回密码功能暂未开放！");
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 50, left: 20.0, right: 20.0),
                  height: 50.0,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Center(
                        child: Text(
                          IntlUtils.getString(context, Ids.user_login),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      onTap: () {
                        //登录
                        _doLogin();
                      },
                    ),
                  ),
                ),
                Gaps.vGap15,
                InkWell(
                  onTap: () {
                    //注册
                    NavigatorUtils.pushPage(context, page: UserRegisterPage());
                  },
                  child: new RichText(
                    text: TextSpan(children: <TextSpan>[
                      new TextSpan(
                          style:
                              TextStyle(color: Colours.gray_66, fontSize: 15),
                          text: IntlUtils.getString(
                              context, Ids.user_new_user_hint)),
                      new TextSpan(
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 15),
                          text: IntlUtils.getString(context, Ids.user_register))
                    ]),
                  ),
                ),

                ///RichText 取代row拼接两个textview更高效
                /*new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      IntlUtils.getString(context, Ids.user_new_user_hint),
                      style: TextStyle(color: Colours.gray_66, fontSize: 15),
                    ),
                    Gaps.hGap5,
                    GestureDetector(
                      onTap: () {
                        //注册
                        NavigatorUtils.pushPage(context, page: UserRegisterPage());
                      },
                      child: Text(
                        IntlUtils.getString(context, Ids.user_register),
                        style: TextStyle(
                            color: Theme.of(context).primaryColor, fontSize: 15.0),
                      ),
                    )
                  ],
                )*/
              ],
            )),
      )
    ]);
  }
}
