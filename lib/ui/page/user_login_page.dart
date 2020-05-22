import 'package:base_library/base_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_start/national/intl_util.dart';
import 'package:flutter_start/res/strings.dart';
import 'package:flutter_start/widget/login_widget.dart';

///登录页
class UserLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            Util.getImgPath("ic_login_bg"),
            package: BaseConstant.packageBase,
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
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      Util.showSnackBar(context, "找回密码功能暂未开放！");
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
                        //TODO 登录
                      },
                    ),
                  ),
                ),
                Gaps.vGap15,
                Center(
                  child: new Row(
                    children: <Widget>[
                      Text(
                        IntlUtils.getString(context, Ids.user_new_user_hint),
                        style: TextStyle(color: Colours.gray_66, fontSize: 14),
                      ),
                      Gaps.hGap5,
                      GestureDetector(
                        onTap: () {
                          //todo 注册
                        },
                        child: Text(
                          IntlUtils.getString(context, Ids.user_register),
                          style: TextStyle(
                              color: Theme.of(context).primaryColor, fontSize: 14.0),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
      )
    ]);
  }
}
