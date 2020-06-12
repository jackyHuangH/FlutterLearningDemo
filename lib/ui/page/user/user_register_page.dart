import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/common/common.dart';
import 'package:flutter_start/event/event.dart';
import 'package:flutter_start/model/protocol/auth_models.dart';
import 'package:flutter_start/model/repository/user_repository.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/util/utils.dart';
import 'package:flutter_start/widget/login_widget.dart';
import 'package:rxdart/rxdart.dart';

//注册页面
class UserRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            Utils.getImgPath("ic_login_bg"),
            package: BaseConstant.packageBase,
            width: double.infinity,
            height: double.infinity,
          ),
          new RegisterBody()
        ],
      ),
    );
  }
}

class RegisterBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController _userController = new TextEditingController();
    TextEditingController _passwordController = new TextEditingController();
    TextEditingController _repasswordController = new TextEditingController();
    UserRepository userRepository = UserRepository();

    void _performRegister() {
      String userName = _userController.text;
      String password = _passwordController.text;
      String repassword = _repasswordController.text;
      if (userName.isEmpty || userName.length < 6) {
        Utils.showToast(IntlUtils.getString(
            context, userName.isEmpty ? Ids.user_login_name_empty : Ids.user_login_name_length_too_short));
        return;
      }
      if (password.isEmpty || password.length < 6) {
        Utils.showToast(IntlUtils.getString(
            context, password.isEmpty ? Ids.user_login_pwd_empty : Ids.user_login_pwd_length_too_short));
        return;
      }
      if (repassword.isEmpty || repassword.length < 6) {
        Utils.showToast(IntlUtils.getString(
            context, repassword.isEmpty ? Ids.user_login_re_pwd_empty : Ids.user_login_re_pwd_length_too_short));
        return;
      }
      if (repassword != password) {
        Utils.showToast(IntlUtils.getString(context, Ids.user_register_pwd_not_equal));
        return;
      }
      RegisterReq registerReq = new RegisterReq(userName, password, repassword);
      userRepository.register(registerReq).then((value) {
        LogUtil.e("RegisterResp:${value.toString()}");
        Utils.showToast(Ids.user_register_success);
        Observable.just(1).delay(Duration(milliseconds: 500)).listen((event) {
          Event.sendAppEvent(context, Constant.type_refresh_all);
          RouteUtil.goMain(context);
        });
      }).catchError((error) {
        LogUtil.e("onError:${error.toString()}");
        Utils.showToast(error.toString());
      });
    }

    return new Column(
      children: <Widget>[
        Expanded(
          child: new Container(),
        ),
        Expanded(
          flex: 4,
          child: new Container(
            margin: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 10.0),
            child: Column(
              children: <Widget>[
                LoginInputItem(
                  prefixIcon: Icons.person,
                  hintText: IntlUtils.getString(context, Ids.user_name),
                  controller: _userController,
                ),
                Gaps.vGap5,
                LoginInputItem(
                  prefixIcon: Icons.lock,
                  hintText: IntlUtils.getString(context, Ids.user_pwd),
                  controller: _passwordController,
                ),
                Gaps.vGap5,
                LoginInputItem(
                  prefixIcon: Icons.lock,
                  hintText: IntlUtils.getString(context, Ids.user_re_pwd),
                  controller: _repasswordController,
                ),
                Container(
                  margin: EdgeInsets.only(left: 15.0, top: 50.0, right: 15.0),
                  height: 50.0,
                  child: Material(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(25.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25.0),
                      onTap: () {
                        //注册
                        _performRegister();
                      },
                      child: Center(
                        child: Text(
                          IntlUtils.getString(context, Ids.user_register),
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
